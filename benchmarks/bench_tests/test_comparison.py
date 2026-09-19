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
        self.assertIn('function minecraft:execute_repeating_functions', text)
        self.assertIn('ability_cleave.drop_inputs', text)


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
