from .common import *
from benchmarks.harness import calibration as benchmark_calibration
from benchmarks.harness.settings import COMMAND_LIMIT_TOLERANCE

class CommandLimitCalibrationTests(unittest.TestCase):
    def args(self, root: Path, *extra: str):
        return bench.build_parser().parse_args([
            'run', 'idle', '--runs', '5',
            '--server-dir', str(root / 'server'),
            '--results-dir', str(root / 'results'),
            *extra,
        ])

    @staticmethod
    def fake_result(args, index: int) -> Path:
        result = args.results_dir / f'result-{index}'
        result.mkdir(parents=True)
        (result / 'summary.md').write_text('summary\n', encoding='utf-8')
        return result

    def test_auto_limit_has_no_calibration_overhead_when_default_passes(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root)
            calls = []

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                return self.fake_result(run_args, len(calls))

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once), redirect_stdout(StringIO()):
                result = bench.run_benchmark(args)

            self.assertEqual(len(calls), 1)
            self.assertEqual(calls[0].command_limit, bench.DEFAULT_COMMAND_LIMIT)
            self.assertEqual(calls[0].runs, 5)
            self.assertEqual(calls[0].command_limit_mode, 'auto')
            self.assertFalse(calls[0].command_limit_calibration['calibrated'])
            self.assertEqual(result.parent, (root / 'results').resolve())
            self.assertTrue((result / 'summary.md').is_file())

    def test_auto_limit_searches_within_configured_tolerance_then_runs_full_invocation(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root)
            calls = []
            threshold = 100000

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                if run_args.command_limit < threshold:
                    raise bench.CommandLimitError(f'limit {run_args.command_limit}')
                return self.fake_result(run_args, len(calls))

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once), redirect_stdout(StringIO()):
                result = bench.run_benchmark(args)

            limits = [call.command_limit for call in calls]
            self.assertEqual(limits[0], bench.DEFAULT_COMMAND_LIMIT)
            self.assertEqual(limits[-1], limits[-2], 'selected probe limit must be rerun for the full invocation')
            final = calls[-1]
            self.assertEqual(final.runs, 5)
            calibration = final.command_limit_calibration
            self.assertTrue(calibration['calibrated'])
            self.assertLess(calibration['known_failing_limit'], threshold)
            self.assertLessEqual(
                calibration['relative_gap_percent'], COMMAND_LIMIT_TOLERANCE * 100.0
            )
            self.assertGreaterEqual(final.command_limit, threshold)
            self.assertLess(final.command_limit, threshold * (1.0 + COMMAND_LIMIT_TOLERANCE))
            self.assertEqual(result.parent, (root / 'results').resolve())

    def test_auto_limit_continues_upward_if_full_invocation_exceeds_probe_limit(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root)
            calls = []

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                threshold = 100000 if run_args.runs == 1 else 110000
                if run_args.command_limit < threshold:
                    raise bench.CommandLimitError(f'limit {run_args.command_limit}')
                return self.fake_result(run_args, len(calls))

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once), redirect_stdout(StringIO()):
                bench.run_benchmark(args)

            full_attempts = [call for call in calls if call.runs == 5]
            self.assertGreaterEqual(len(full_attempts), 3)  # initial default, too-tight calibrated run, final run
            self.assertLess(full_attempts[-2].command_limit, 110000)
            self.assertGreaterEqual(full_attempts[-1].command_limit, 110000)
            self.assertLessEqual(
                full_attempts[-1].command_limit_calibration['relative_gap_percent'],
                COMMAND_LIMIT_TOLERANCE * 100.0,
            )

    def test_auto_limit_does_not_retry_non_limit_failures(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root)
            calls = []

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                raise bench.BenchmarkInvalidError('broken workload')

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once), redirect_stdout(StringIO()):
                with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'broken workload'):
                    bench.run_benchmark(args)

            self.assertEqual(len(calls), 1)
            self.assertEqual(calls[0].command_limit, bench.DEFAULT_COMMAND_LIMIT)

    def test_auto_limit_will_not_reuse_a_world_after_limit_failure(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root, '--reuse-server')
            calls = []

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                raise bench.CommandLimitError('limit')

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once), redirect_stdout(StringIO()):
                with self.assertRaisesRegex(bench.BenchmarkError, 'requires fresh worlds'):
                    bench.run_benchmark(args)

            self.assertEqual(len(calls), 1)
            self.assertTrue(calls[0].reuse_server)

    def test_explicit_limit_bypasses_auto_calibration(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = self.args(root, '--command-limit', '200000')
            calls = []

            def run_once(run_args, **_kwargs):
                calls.append(run_args)
                return self.fake_result(run_args, len(calls))

            with patch.object(benchmark_calibration, '_run_benchmark_once', side_effect=run_once):
                result = bench.run_benchmark(args)

            self.assertEqual(len(calls), 1)
            self.assertEqual(calls[0].command_limit, 200000)
            self.assertEqual(calls[0].command_limit_mode, 'explicit')
            self.assertIsNone(calls[0].command_limit_calibration)
            self.assertEqual(result, calls[0].results_dir / 'result-1')

    def test_summary_reports_auto_calibration_bounds(self):
        text = bench.command_limit_summary(102400, {
            'calibrated': True,
            'known_failing_limit': 98304,
            'relative_gap_percent': 4.1667,
        })
        self.assertIn('102400', text)
        self.assertIn('known failure at 98304', text)
        self.assertIn('4.17%', text)
