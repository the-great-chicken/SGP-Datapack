from .common import *

class FailureDiagnosticsTests(unittest.TestCase):
    def test_failure_bundle_keeps_logs_and_generated_plan(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            result = root / 'results' / 'failed-run'
            result.mkdir(parents=True)
            server_dir = root / 'server'
            active = server_dir / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/generated/active'
            active.mkdir(parents=True)
            (active / 'setup.mcfunction').write_text('# generated setup\n', encoding='utf-8')
            (server_dir / 'benchmark-console.log').write_text('console line\n', encoding='utf-8')
            (server_dir / 'logs').mkdir()
            (server_dir / 'logs/latest.log').write_text('latest line\n', encoding='utf-8')
            (server_dir / 'server.properties').write_text('level-name=world\n', encoding='utf-8')

            fake_server = type('FakeServer', (), {'lines': ['line 1', 'line 2']})()
            scenarios = bench.load_scenarios()
            _, _, plan = bench.resolve_plan(scenarios, 'idle', players=1)
            metadata = {'scenario': 'idle', 'status': 'running'}
            bench.write_failure_bundle(
                result, metadata, 'creating benchmark fixture',
                bench.BenchmarkError('fixture did not initialize'), server_dir, fake_server, plan,
            )

            failure = json.loads((result / 'failure.json').read_text(encoding='utf-8'))
            self.assertEqual(failure['phase'], 'creating benchmark fixture')
            self.assertIn('fixture did not initialize', failure['error'])
            self.assertTrue((result / 'failure.md').is_file())
            self.assertTrue((result / 'diagnostics/benchmark-console.log').is_file())
            self.assertTrue((result / 'diagnostics/latest.log').is_file())
            self.assertTrue((result / 'diagnostics/generated-active/setup.mcfunction').is_file())
