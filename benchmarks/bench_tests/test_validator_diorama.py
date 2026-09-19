from .common import *


class DioramaValidatorTests(unittest.TestCase):
    limit_line = LIMIT_LINE
    server = staticmethod(make_server)

    def test_diorama_profile_requires_one_update_per_player_per_tick(self):
        plan = [{'scenario': 'diorama_giant', 'players': 50}, {'scenario': 'idle', 'players': 10}]
        run = {'tick_span': 201, 'command_function_entries': [
            {'name': 'prepare execute as @e[...] run function sgp.diorama:tick/update_mannequin/apply_mannequin_pos', 'count': 10050},
        ]}
        self.assertEqual(bench.validate_diorama_workload(run, plan), {'diorama_mannequin_updates': 10050})
        for count in [201, 0, 10049, 10051]:
            run['command_function_entries'][0]['count'] = count
            with self.subTest(count=count), self.assertRaises(bench.BenchmarkInvalidError):
                bench.validate_diorama_workload(run, plan)
        for run in [{'tick_span': 201}, {'tick_span': 0}, {}]:
            with self.assertRaises(bench.BenchmarkInvalidError):
                bench.validate_diorama_workload(run, plan)
        self.assertEqual(bench.validate_diorama_workload({}, [{'scenario': 'idle', 'players': 50}]), {})

    def test_diorama_entity_checks_require_distinct_owners_and_complete_cleanup(self):
        server = self.server()
        plan = [{'scenario': 'diorama_giant', 'players': 50, 'first': 11, 'last': 60}]
        with patch.object(server, 'send') as send, patch.object(server, 'score', side_effect=[50, 50]):
            bench.require_diorama_entities(server, plan)
            self.assertIn('sgp.bench=11..60', send.call_args_list[-1].args[0])
        for values in [[1], [51], [None], [50, 1], [50, None]]:
            with self.subTest(values=values), patch.object(server, 'send'), \
                 patch.object(server, 'score', side_effect=values):
                with self.assertRaises(bench.BenchmarkInvalidError):
                    bench.require_diorama_entities(server, plan)
        with patch.object(server, 'send'), patch.object(server, 'score', return_value=0):
            bench.require_diorama_entities(server, plan, after_reset=True)
        with patch.object(server, 'send'), patch.object(server, 'score', return_value=1):
            with self.assertRaises(bench.BenchmarkInvalidError):
                bench.require_diorama_entities(server, plan, after_reset=True)

    def test_comparison_rejects_reduced_diorama_workload_even_with_allow_mismatch(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root/'before', root/'after'
            write_result_fixture(before, 8.0, 5.0)
            write_result_fixture(after, 6.0, 3.0)
            path = after/'metadata.json'
            metadata = json.loads(path.read_text())
            metadata['plan'] = [{'scenario': 'diorama_giant', 'players': 50}]
            path.write_text(json.dumps(metadata))
            args = bench.build_parser().parse_args(['compare', str(before), str(after), '--allow-mismatch'])
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'Incomplete Diorama workload'):
                bench.compare_results(args)
