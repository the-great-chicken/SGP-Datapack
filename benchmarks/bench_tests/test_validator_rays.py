from .common import *


class RaysValidatorTests(unittest.TestCase):
    limit_line = LIMIT_LINE
    server = staticmethod(make_server)

    def test_recorded_rays_validation_is_semantic_not_profiler_text(self):
        plan = [{'scenario': 'ability_rays', 'players': 25}, {'scenario': 'ability_rays_dense', 'players': 15}]
        run = {
            'tick_span': 108,
            'validated_workload': {
                'ray_players': 40,
                'ray_entities': 320,
                'ray_valid_owners': 40,
            },
            'command_function_entries': [{'name': 'completely different optimized implementation', 'count': 1}],
        }
        self.assertEqual(bench.validate_ray_workload(run, plan), run['validated_workload'])

    def test_old_or_incomplete_rays_results_cannot_be_compared_as_valid(self):
        plan = [{'scenario': 'ability_rays', 'players': 40}]
        for validated in [None, {}, {'ray_players': 40, 'ray_entities': 288, 'ray_valid_owners': 36}]:
            with self.subTest(validated=validated):
                run = {'tick_span': 108}
                if validated is not None:
                    run['validated_workload'] = validated
                with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'semantic ownership validation'):
                    bench.validate_ray_workload(run, plan)

    def test_rays_validation_requires_a_real_profile_window(self):
        plan = [{'scenario': 'ability_rays', 'players': 40}]
        run = {'validated_workload': {'ray_players': 40, 'ray_entities': 320, 'ray_valid_owners': 40}}
        with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'positive profile tick count'):
            bench.validate_ray_workload(run, plan)

    def test_rays_validation_is_a_noop_for_non_rays_workloads(self):
        self.assertEqual(bench.validate_ray_workload({}, [{'scenario': 'idle', 'players': 40}]), {})

    def test_ray_entity_checks_use_aggregate_fast_path_and_diagnose_failures(self):
        server = self.server()
        plan = [{'scenario': 'ability_rays', 'players': 2, 'first': 1, 'last': 2}]

        aggregate = {
            '#actual_rays': 16,
            '#ray_with_link': 16,
            '#ray_valid_owners': 2,
            '#ray_owned_by_actors': 16,
        }
        current = {'actor': None}
        state = {
            'Bench01': {'bs.id': 101, 'linked': 8},
            'Bench02': {'bs.id': 102, 'linked': 8},
        }

        def send(command):
            if command.startswith('execute as Bench') and 'verify_owner' in command:
                current['actor'] = command.split()[2]

        def score(player, objective='sgp.bench', timeout=5.0):
            actor = current['actor']
            if actor is None and player in aggregate:
                return aggregate[player]
            if actor is not None and player == '#ray_linked':
                return state[actor]['linked']
            if actor is not None and player == '#ray_owner_id':
                return state[actor]['bs.id']
            return None

        with patch.object(server, 'send', side_effect=send) as send_mock, \
             patch.object(server, 'score', side_effect=score) as score_mock:
            self.assertEqual(bench.require_ray_entities(server, plan), {
                'ray_players': 2, 'ray_entities': 16, 'ray_valid_owners': 2,
            })
            commands = [call.args[0] for call in send_mock.call_args_list]
            self.assertTrue(any('scores={sgp.bench=1..2}' in command and 'verify_owner' in command
                                for command in commands))
            self.assertTrue(any('tag=sgp.bench.ray_owned' in command and '#ray_owned_by_actors' in command
                                for command in commands))
            self.assertFalse(any(command.startswith('execute as Bench') for command in commands))
            self.assertEqual([call.args[0] for call in score_mock.call_args_list], [
                '#actual_rays', '#ray_with_link', '#ray_valid_owners', '#ray_owned_by_actors',
            ])

        aggregate.update({'#ray_valid_owners': 1, '#ray_owned_by_actors': 8})
        state['Bench02']['linked'] = 0
        current['actor'] = None
        with patch.object(server, 'send', side_effect=send), patch.object(server, 'score', side_effect=score):
            with self.assertRaisesRegex(
                bench.BenchmarkInvalidError,
                r'rays with any link 16/16, rays owned by benchmark actors 8/16, valid owners 1/2.*'
                r'Bench02\(bs.id=102, linked=0\)',
            ):
                bench.require_ray_entities(server, plan)

        with patch.object(server, 'send'), patch.object(server, 'score', return_value=0):
            self.assertEqual(bench.require_ray_entities(server, plan, after_reset=True), {})
        with patch.object(server, 'send'), patch.object(server, 'score', return_value=1):
            with self.assertRaises(bench.BenchmarkInvalidError):
                bench.require_ray_entities(server, plan, after_reset=True)
