from .common import *
from benchmarks.harness import runner as benchmark_runner

class RunnerIntegrityTests(unittest.TestCase):
    limit_line = LIMIT_LINE
    server = staticmethod(make_server)

    def test_interrupted_invocation_stops_and_preserves_failure_instead_of_continuing(self):
        commands = []
        limit_line = self.limit_line
        class InterruptedServer(bench.ServerProcess):
            def start(self, timeout):
                pass

            def send(self, command):
                commands.append(command)
                if command == 'function sgp.bench:start':
                    self.lines.append(limit_line)

            def require_score(self, player, expected, objective='sgp.bench'):
                self.check_health()
                return expected

            def score(self, player, objective='sgp.bench', timeout=5.0):
                return {
                    '#actor_chunks_loaded': 1,
                    '#actual_in_game': 40,
                    '#actual_rays': 320,
                    '#ray_with_link': 320,
                    '#ray_valid_owners': 40,
                    '#ray_owned_by_actors': 320,
                }.get(player)

            def stop(self, force=False):
                commands.append('stop')

        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            args = bench.build_parser().parse_args([
                'run', 'ability_rays', '--players', '40', '--runs', '5', '--command-limit', '1000000',
                '--server-dir', str(root/'server'), '--results-dir', str(root/'results'),
            ])
            def prepare(server, cache):
                server.mkdir()
                (server/bench.SERVER_MARKER).write_text('benchmark')
                (server/'server.jar').write_bytes(b'not launched')
            with patch.object(benchmark_runner, 'prepare_server', side_effect=prepare), \
                 patch.object(benchmark_runner, 'ServerProcess', InterruptedServer), \
                 patch.object(benchmark_runner, 'git_commit', return_value=None), \
                 patch.object(benchmark_runner, 'git_dirty', return_value=False), \
                 patch.object(benchmark_runner, 'source_fingerprint', return_value='test-source'), \
                 redirect_stdout(StringIO()):
                with self.assertRaises(bench.BenchmarkInvalidError):
                    bench.run_benchmark(args)
            result = next((root/'results').iterdir())
            metadata = json.loads((result/'metadata.json').read_text())
            self.assertEqual(metadata['status'], 'failed')
            self.assertEqual(metadata['command_limit'], 1000000)
            self.assertIs(metadata['git_dirty'], False)
            self.assertTrue((result/'failure.json').is_file())
            self.assertFalse((result/'summary.md').exists())
            self.assertTrue((root/'server'/bench.INVALID_MARKER).is_file())
            self.assertEqual(commands.count('function sgp.bench:start'), 1)
            readiness_check = next(i for i, command in enumerate(commands) if '#actor_chunks_loaded' in command)
            scenario_setup = commands.index('function sgp.bench:generated/active/setup')
            self.assertLess(readiness_check, scenario_setup)
            in_game_check = next(i for i, command in enumerate(commands) if '#actual_in_game' in command)
            initial_ray_check = next(i for i, command in enumerate(commands) if '#actual_rays' in command)
            self.assertLess(in_game_check, initial_ray_check)
            self.assertLess(initial_ray_check, commands.index('function sgp.bench:start'))
            self.assertNotIn('perf start', commands)
            self.assertEqual(commands[-1], 'stop')

    def test_actor_in_game_invariant_rejects_partial_membership(self):
        server = self.server()
        commands = []
        with patch.object(server, 'send', side_effect=commands.append), \
             patch.object(server, 'score', return_value=39):
            with self.assertRaisesRegex(
                bench.BenchmarkInvalidError,
                'expected 40 actors to remain sgp.in_game, got 39',
            ):
                benchmark_runner.require_actor_in_game(server, 40)

        self.assertEqual(commands, [
            'execute store result score #actual_in_game sgp.bench '
            'if entity @a[tag=sgp.bench.actor,tag=sgp.in_game]'
        ])
