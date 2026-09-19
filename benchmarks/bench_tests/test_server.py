from .common import *


class ServerIntegrityTests(unittest.TestCase):
    limit_line = LIMIT_LINE
    server = staticmethod(make_server)

    def test_limit_failure_is_sticky_and_precedes_successful_response(self):
        server = self.server()
        server.lines.extend([self.limit_line, 'Done (1.0s)! For help, type help'])
        for _ in range(2):
            with self.assertRaisesRegex(bench.CommandLimitError, str(bench.DEFAULT_COMMAND_LIMIT)):
                server.wait_for(lambda line: 'Done (' in line, 0, start_at=1)

    def test_limit_arriving_after_an_earlier_health_check_is_detected(self):
        server = self.server()
        server.lines.append('normal output')
        server.check_health()
        server.lines.append(self.limit_line)
        with self.assertRaises(bench.CommandLimitError):
            server.sleep_alive(0)

    def test_function_load_failure_is_sticky_health_failure(self):
        server = self.server()
        server.lines.append('[Server thread/ERROR]: Failed to load function sgp.bench:broken - parse error')
        for _ in range(2):
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'Failed to load function'):
                server.check_health()

    def test_score_does_not_swallow_command_limit_failure(self):
        server = self.server()
        def respond(command):
            server.lines.extend([self.limit_line, '#players has 40 [sgp.bench]'])
        with patch.object(server, 'send', side_effect=respond):
            with self.assertRaises(bench.CommandLimitError):
                server.score('#players')

    def test_score_accepts_objective_display_name(self):
        server = self.server()
        def respond(command):
            self.assertEqual(command, 'scoreboard players get Bench01 bs.id')
            server.lines.append('[Server thread/INFO]: Bench01 has 17 [BS ID]')
        with patch.object(server, 'send', side_effect=respond):
            self.assertEqual(server.score('Bench01', 'bs.id', timeout=0.1), 17)

    def test_profile_wait_aborts_before_accepting_an_archive(self):
        server = self.server()
        server.lines.append(self.limit_line)
        with tempfile.TemporaryDirectory() as temporary:
            with self.assertRaises(bench.CommandLimitError):
                bench.wait_for_new_profile(Path(temporary), set(), server, timeout=1)

    def test_actor_chunk_readiness_waits_for_all_generated_actor_chunks(self):
        server = self.server()
        observed = []
        scores = iter([0, 1])

        def send(command):
            observed.append(command)

        with patch.object(server, 'send', side_effect=send), \
             patch.object(server, 'score', side_effect=lambda player, objective='sgp.bench', timeout=5.0: next(scores)), \
             patch.object(server, 'sleep_alive') as sleep_alive:
            bench.wait_for_actor_chunks_loaded(server, 40, timeout=1.0)

        readiness = [command for command in observed if command.startswith(
            'execute store success score #actor_chunks_loaded sgp.bench '
        )]
        self.assertEqual(len(readiness), 2)
        # Forty actors occupy four X chunks and two Z chunks in the generated grid.
        self.assertEqual(readiness[0].count('if loaded '), 8)
        self.assertIn('if loaded -32 81 -16', readiness[0])
        self.assertIn('if loaded 16 81 0', readiness[0])
        self.assertEqual(observed[-1], 'scoreboard players reset #actor_chunks_loaded sgp.bench')
        sleep_alive.assert_called_once()
