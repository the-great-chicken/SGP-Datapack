from .common import *
from benchmarks.harness.validators.bats import (
    BATS_PER_ACTIVATION,
    EXPLOSIONS_PER_STACKED_ACTIVATION,
    WORKLOAD_CONSTANTS,
    BatsDetonatingValidator,
)


PLAYERS = 40
COMPLETE_WAVES = 5
DEFAULT_SPAWNED = PLAYERS * BATS_PER_ACTIVATION * COMPLETE_WAVES
SIX_WAVES_SPAWNED = PLAYERS * BATS_PER_ACTIVATION * 6
DEFAULT_EXPLOSIONS = PLAYERS * EXPLOSIONS_PER_STACKED_ACTIVATION * COMPLETE_WAVES


class BatsDetonatingValidatorTests(unittest.TestCase):
    server = staticmethod(make_server)

    @staticmethod
    def plan(players=PLAYERS, period=40):
        return [{
            'scenario': 'ability_bats_detonating',
            'players': players,
            'first': 1,
            'last': players,
            'parameters': {'period': period},
        }]

    @staticmethod
    def make_run(ticks=199, spawned=DEFAULT_SPAWNED, explosions=DEFAULT_EXPLOSIONS, *, validated=True,
                 constants=None):
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
                'bats_players': PLAYERS,
                'bats_spawned': spawned,
                'bats_explosions': explosions,
                'bats_target_mannequins': PLAYERS,
                'bats_targets_in_place': PLAYERS,
                **(WORKLOAD_CONSTANTS if constants is None else constants),
            }
        return run

    def test_profile_validation_accounts_for_driver_to_production_tick_delay(self):
        plan = self.plan()
        self.assertEqual(bench.validate_bats_profile(self.make_run(validated=False), plan), {
            'bats_players': PLAYERS,
            'bats_spawned': DEFAULT_SPAWNED,
            'bats_explosions': DEFAULT_EXPLOSIONS,
            **WORKLOAD_CONSTANTS,
        })

        # The benchmark driver fires on tick 201, after production ability routing
        # already ran. Those bats are not created until tick 202.
        run = self.make_run(ticks=201, spawned=DEFAULT_SPAWNED, explosions=DEFAULT_EXPLOSIONS, validated=False)
        self.assertEqual(bench.validate_bats_profile(run, plan)['bats_spawned'], DEFAULT_SPAWNED)

        # A 202-tick capture includes that sixth production activation, but its
        # 1-second detonation deadline remains outside the profile.
        run = self.make_run(ticks=202, spawned=SIX_WAVES_SPAWNED, explosions=DEFAULT_EXPLOSIONS, validated=False)
        validated = bench.validate_bats_profile(run, plan)
        self.assertEqual(validated['bats_spawned'], SIX_WAVES_SPAWNED)
        self.assertEqual(validated['bats_explosions'], DEFAULT_EXPLOSIONS)

    def test_profile_validation_rejects_missing_coalesced_explosions(self):
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'coalesced explosion workload'):
            bench.validate_bats_profile(
                self.make_run(spawned=DEFAULT_SPAWNED, explosions=80, validated=False),
                self.plan(),
            )

    def test_persisted_validation_requires_live_target_result(self):
        run = self.make_run(validated=False)
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'semantic target validation'):
            bench.validate_bats_workload(run, self.plan())

        run = self.make_run()
        self.assertEqual(bench.validate_bats_workload(run, self.plan()), run['validated_workload'])

    def test_persisted_validation_uses_recorded_workload_constants(self):
        plan = self.plan()
        ten_bats = {'bats_per_activation': 10, 'bats_explosions_per_activation': 1}
        run = self.make_run(spawned=PLAYERS * 10 * COMPLETE_WAVES, constants=ten_bats)
        self.assertEqual(bench.validate_bats_workload(run, plan)['bats_per_activation'], 10)

        # A result recorded before constants were stored is checked against the current constants.
        legacy = self.make_run(spawned=PLAYERS * 10 * COMPLETE_WAVES, constants={})
        with self.assertRaisesRegex(
            bench.BenchmarkInvalidError, f'grenade bats {PLAYERS * 10 * COMPLETE_WAVES}/{DEFAULT_SPAWNED}'
        ):
            bench.validate_bats_workload(legacy, plan)

        tampered = self.make_run()
        tampered['validated_workload']['bats_per_activation'] = 9
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'grenade bats'):
            bench.validate_bats_workload(tampered, plan)

    def test_profile_validation_records_workload_constants(self):
        live = {'bats_target_mannequins': PLAYERS, 'bats_targets_in_place': PLAYERS}
        result = BatsDetonatingValidator().validate_profile(self.make_run(validated=False), self.plan(), live)
        self.assertEqual(result['bats_per_activation'], BATS_PER_ACTIVATION)
        self.assertEqual(result['bats_explosions_per_activation'], EXPLOSIONS_PER_STACKED_ACTIVATION)
        self.assertEqual(BatsDetonatingValidator.constants, WORKLOAD_CONSTANTS)

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
        warmup_bats = 2 * BATS_PER_ACTIVATION
        scores = iter([warmup_bats, warmup_bats, 0])
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
