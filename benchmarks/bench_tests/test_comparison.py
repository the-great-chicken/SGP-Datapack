from .common import *

class ComparisonTests(unittest.TestCase):
    write_result = staticmethod(write_result_fixture)

    def test_compare_reports_delta(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before = root / 'before'
            after = root / 'after'
            self.write_result(before, 8.0, 5.0)
            self.write_result(after, 6.0, 3.0)
            args = type('Args', (), {
                'before': before,
                'after': after,
                'allow_mismatch': False,
                'top': 10,
                'output': None,
            })()
            output = StringIO()
            with redirect_stdout(output):
                bench.compare_results(args)
            text = output.getvalue()
        self.assertIn('-2.000 pp (-25.0%)', text)
        self.assertIn('| Mean MSPT (server work per tick) | n/a ms | n/a ms | n/a |', text)
        self.assertIn('| `commandFunctions` ms/tick | 4.000 ms | 3.000 ms | -25.0% |', text)
        self.assertIn('| Tick period median | 4.000 ms | 4.000 ms |', text)
        self.assertNotIn('| Tick median |', text)
        self.assertIn('- Source before: commit `0123456789ab` (clean)', text)
        self.assertIn('function minecraft:execute_repeating_functions', text)
        self.assertIn('ability_cleave.drop_inputs', text)

    def test_compare_validates_stored_results_even_with_empty_validator_list(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root / 'before', root / 'after'
            self.write_result(before, 8.0, 5.0)
            self.write_result(after, 6.0, 3.0)
            args = bench.build_parser().parse_args(['compare', str(before), str(after), '--allow-mismatch'])
            path = after / 'metadata.json'
            original = json.loads(path.read_text())
            path.write_text(json.dumps({
                **original,
                'validators': [],
                'plan': [{'scenario': 'ability_rays', 'players': 40}],
            }))
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'semantic ownership validation'):
                bench.compare_results(args)

    def test_compare_rejects_differing_validator_constants(self):
        plan = [{
            'scenario': 'ability_bats_detonating',
            'players': 40,
            'first': 1,
            'last': 40,
            'parameters': {'period': 40},
        }]
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root / 'before', root / 'after'
            self.write_result(before, 8.0, 5.0)
            self.write_result(after, 6.0, 3.0)
            for directory, bats in ((before, 10), (after, 8)):
                metadata_path = directory / 'metadata.json'
                metadata = json.loads(metadata_path.read_text())
                metadata_path.write_text(json.dumps({**metadata, 'plan': plan, 'validators': ['bats_detonating']}))
                # tick_span 200 with period 40: five activations and five completed detonations.
                spawned = 40 * bats * 5
                for run_path in directory.glob('run-*.json'):
                    run = json.loads(run_path.read_text())
                    run['command_function_entries'] = [{
                        'name': (
                            'prepare execute summon bat run function sgp.misc:summon_multiple_exec '
                            '{nbt:{Tags:["sgp.bat_grenade"]}}'
                        ),
                        'count': spawned,
                    }]
                    run['scheduled_function_entries'] = [{
                        'name': 'execute summon tnt ~ ~ ~ {explosion_power:1.3f,fuse:0s,Tags:["sgp.bat_grenade", "sgp.new"]}',
                        'count': 40 * 5,
                    }]
                    run['validated_workload'] = {
                        'bats_players': 40,
                        'bats_spawned': spawned,
                        'bats_explosions': 200,
                        'bats_target_mannequins': 40,
                        'bats_targets_in_place': 40,
                        'bats_per_activation': bats,
                        'bats_explosions_per_activation': 1,
                    }
                    run_path.write_text(json.dumps(run))
            args = bench.build_parser().parse_args(['compare', str(before), str(after)])
            with self.assertRaisesRegex(
                bench.BenchmarkError, 'Validated workload constants differ.*bats_per_activation 10 vs 8'
            ):
                bench.compare_results(args)
            args.allow_mismatch = True
            output = StringIO()
            with redirect_stdout(output):
                bench.compare_results(args)
            self.assertIn('| `bats_per_activation` | 10 | 8 | -20.0% |', output.getvalue())


    def test_compare_rejects_environment_mismatches_without_override(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root / 'before', root / 'after'
            self.write_result(before, 8.0, 5.0)
            self.write_result(after, 6.0, 3.0)
            args = bench.build_parser().parse_args(['compare', str(before), str(after)])
            path = after / 'metadata.json'
            original = json.loads(path.read_text())
            for field, value in [('heap', '4G'), ('warmup_seconds', 10.0), ('minecraft_version', '26.1.3')]:
                with self.subTest(field=field):
                    path.write_text(json.dumps({**original, field: value}))
                    with self.assertRaisesRegex(bench.BenchmarkError, 'configurations do not match'):
                        bench.compare_results(args)

    def test_comparison_rejects_failed_incomplete_or_mismatched_results(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root/'before', root/'after'
            write_result_fixture(before, 8.0, 5.0)
            write_result_fixture(after, 6.0, 3.0)
            args = bench.build_parser().parse_args(['compare', str(before), str(after)])
            path = after/'metadata.json'
            original = json.loads(path.read_text())
            for change in [{'status': 'failed'}, {'runs': 4}, {'command_limit': 1000000}]:
                path.write_text(json.dumps({**original, **change}))
                with self.assertRaises(bench.BenchmarkError):
                    bench.compare_results(args)
            path.write_text(json.dumps({**original, 'plan': [{'scenario': 'ability_rays', 'players': 40}]}))
            args.allow_mismatch = True
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'semantic ownership validation'):
                bench.compare_results(args)
