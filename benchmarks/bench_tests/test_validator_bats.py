from .common import *


class BatsDetonatingValidatorTests(unittest.TestCase):
    server = staticmethod(make_server)

    @staticmethod
    def plan(players=40, period=40):
        return [{
            'scenario': 'ability_bats_detonating',
            'players': players,
            'first': 1,
            'last': players,
            'parameters': {'period': period},
        }]

    @staticmethod
    def make_run(ticks=199, spawned=2000, explosions=200, *, validated=True):
        run = {
            'tick_span': ticks,
            'command_function_entries': [{
                'name': (
                    'prepare execute summon bat run function sgp.misc:summon_multiple_exec '
                    '{nbt:{Tags:["sgp.bat_grenade"]}}'
                ),
                'count': spawned,
            }],
            'scheduled_function_entries': [{
                'name': (
                    'execute summon tnt ~ ~ ~ '
                    '{explosion_power:1.3f,fuse:0s,Tags:["sgp.bat_grenade", "sgp.new"]}'
                ),
                'count': explosions,
            }],
        }
        if validated:
            run['validated_workload'] = {
                'bats_players': 40,
                'bats_spawned': spawned,
                'bats_explosions': explosions,
                'bats_target_mannequins': 40,
                'bats_targets_in_place': 40,
            }
        return run

    def test_profile_validation_accounts_for_driver_to_production_tick_delay(self):
        plan = self.plan()
        self.assertEqual(bench.validate_bats_profile(self.make_run(validated=False), plan), {
            'bats_players': 40,
            'bats_spawned': 2000,
            'bats_explosions': 200,
        })

        # The benchmark driver fires on tick 201, after production ability routing
        # already ran. Those bats are not created until tick 202.
        run = self.make_run(ticks=201, spawned=2000, explosions=200, validated=False)
        self.assertEqual(bench.validate_bats_profile(run, plan)['bats_spawned'], 2000)

        # A 202-tick capture includes that sixth production activation, but its
        # 1-second detonation deadline remains outside the profile.
        run = self.make_run(ticks=202, spawned=2400, explosions=200, validated=False)
        validated = bench.validate_bats_profile(run, plan)
        self.assertEqual(validated['bats_spawned'], 2400)
        self.assertEqual(validated['bats_explosions'], 200)

    def test_profile_validation_rejects_missing_coalesced_explosions(self):
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'coalesced explosion workload'):
            bench.validate_bats_profile(
                self.make_run(spawned=2000, explosions=80, validated=False),
                self.plan(),
            )

    def test_persisted_validation_requires_live_target_result(self):
        run = self.make_run(validated=False)
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'semantic target validation'):
            bench.validate_bats_workload(run, self.plan())

        run = self.make_run()
        self.assertEqual(bench.validate_bats_workload(run, self.plan()), run['validated_workload'])

    def test_live_validation_requires_one_target_at_each_actor(self):
        server = self.server()
        scores = {
            '#bats_targets': 2,
            '#bats_targets_in_place': 2,
        }
        with patch.object(server, 'send') as send_mock, \
             patch.object(server, 'score', side_effect=lambda player, objective='sgp.bench', timeout=5.0: scores[player]):
            self.assertEqual(bench.require_bat_targets(server, self.plan(players=2)), {
                'bats_target_mannequins': 2,
                'bats_targets_in_place': 2,
            })
        commands = [call.args[0] for call in send_mock.call_args_list]
        self.assertTrue(any('scores={sgp.bench=1..2}' in command for command in commands))
        self.assertTrue(any('distance=..0.25' in command for command in commands))

        scores['#bats_targets_in_place'] = 1
        with patch.object(server, 'send'), \
             patch.object(server, 'score', side_effect=lambda player, objective='sgp.bench', timeout=5.0: scores[player]), \
             self.assertRaisesRegex(bench.BenchmarkInvalidError, 'moved away'):
            bench.require_bat_targets(server, self.plan(players=2))

    def test_measurement_wait_requires_killed_warmup_bats_to_be_removed(self):
        server = self.server()
        scores = iter([400, 400, 0])
        with patch.object(server, 'send') as send_mock, \
             patch.object(server, 'score', side_effect=lambda *args, **kwargs: next(scores)), \
             patch.object(server, 'sleep_alive') as sleep_mock:
            bench.wait_for_bat_cleanup(server, self.plan(players=2), timeout=5.0)

        commands = [call.args[0] for call in send_mock.call_args_list]
        self.assertEqual(
            commands.count(
                'execute store result score #bats_measurement_grenades sgp.bench '
                'if entity @e[tag=sgp.bat_grenade]'
            ),
            3,
        )
        self.assertEqual(commands[-1], 'scoreboard players reset #bats_measurement_grenades sgp.bench')
        self.assertEqual(sleep_mock.call_count, 2)

    def test_reset_validation_requires_targets_and_grenades_gone(self):
        server = self.server()
        scores = {'#bats_targets': 0, '#bats_grenades': 0}
        with patch.object(server, 'send'), \
             patch.object(server, 'score', side_effect=lambda player, objective='sgp.bench', timeout=5.0: scores[player]):
            self.assertEqual(bench.require_bat_targets(server, self.plan(players=2), after_reset=True), {})

        scores['#bats_grenades'] = 1
        with patch.object(server, 'send'), \
             patch.object(server, 'score', side_effect=lambda player, objective='sgp.bench', timeout=5.0: scores[player]), \
             self.assertRaisesRegex(bench.BenchmarkInvalidError, 'grenade entities'):
            bench.require_bat_targets(server, self.plan(players=2), after_reset=True)
