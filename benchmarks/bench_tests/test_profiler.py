from .common import *

class ProfileParserTests(unittest.TestCase):
    def make_profile(self, directory: Path) -> Path:
        text = '''---- Minecraft Profiler Results ----
Version: 26.1.2
Time span: 10000.0 ms
Tick span: 200 ticks
--- BEGIN PROFILE DUMP ---
[00] root(1/0) - 100.00%/100.00%
[01] |   tick(200/1) - 90.00%/90.00%
[02] |   |   commandFunctions(200/1) - 10.00%/9.00%
[03] |   |   |   function minecraft:execute_repeating_functions(200/1) - 60.00%/5.40%
[04] |   |   |   |   execute as @a[tag=sgp.in_game] run function sgp.kits:abilities/tick(8000/40) - 50.00%/2.70%
[02] |   |   levels(200/1) - 20.00%/18.00%
'''
        archive = directory / 'profile.zip'
        with zipfile.ZipFile(archive, 'w') as output:
            output.writestr('server/profiling.txt', text)
            output.writestr(
                'server/metrics/ticking.csv',
                '@timestamp,ticktime\n'
                '0,1000000\n'
                '1,2000000\n'
                '2,3000000\n'
                '3,4000000\n'
                '4,5000000\n',
            )
        return archive

    def test_parse_command_functions_subtree(self):
        with tempfile.TemporaryDirectory() as temporary:
            profile = bench.parse_profile(self.make_profile(Path(temporary)))
        self.assertEqual(profile.version, '26.1.2')
        self.assertEqual(profile.tick_span, 200)
        self.assertAlmostEqual(profile.effective_tps, 20.0)
        self.assertAlmostEqual(profile.command_functions_percent, 9.0)
        self.assertEqual(profile.tick_times_ms, [1.0, 2.0, 3.0, 4.0, 5.0])
        self.assertAlmostEqual(profile.tick_median_ms, 3.0)
        self.assertAlmostEqual(profile.tick_p95_ms, 5.0)
        self.assertAlmostEqual(profile.tick_max_ms, 5.0)
        self.assertEqual(len(profile.entries), 2)
        self.assertEqual(profile.entries[0].name, 'function minecraft:execute_repeating_functions')
        self.assertEqual(profile.entries[1].count, 8000)

    def test_profile_wait_preserves_validated_snapshot(self):
        class AliveProcess:
            def __init__(self):
                self.process = self

            def poll(self):
                return None

            def check_health(self):
                pass

        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary)
            profile_dir = server / 'debug/profiling'
            profile_dir.mkdir(parents=True)
            source = self.make_profile(profile_dir)
            destination = server / 'results/run-01.zip'
            captured = bench.wait_for_new_profile(
                server, set(), AliveProcess(), timeout=2.0, destination=destination
            )
            self.assertEqual(captured, destination)
            source.unlink()
            profile = bench.parse_profile(destination)
        self.assertEqual(profile.tick_span, 200)

    def test_logical_commands_joins_continuations_and_ignores_macros(self):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'x.mcfunction'
            path.write_text(
                '# comment\nexecute as @a \\\n    at @s run say hello\n$scoreboard players set @s foo $(value)\n',
                encoding='utf-8',
            )
            commands = list(bench.logical_commands(path))
        self.assertEqual(commands, [(2, 'execute as @a at @s run say hello')])
