from .common import *

class ProfileParserTests(unittest.TestCase):
    def make_profile(self, directory: Path) -> Path:
        text = '''---- Minecraft Profiler Results ----
Version: 26.1.2
Time span: 10000.0 ms
Tick span: 200 ticks
--- BEGIN PROFILE DUMP ---

[00] nextTickWait(200/1) - 10.00%/10.00%
[00] tick(200/1) - 90.00%/90.00%
[01] |   commandFunctions(200/1) - 10.00%/9.00%
[02] |   |   function minecraft:execute_repeating_functions(200/1) - 60.00%/5.40%
[03] |   |   |   execute as @a[tag=sgp.in_game] run function sgp.kits:abilities/tick(8000/40) - 50.00%/2.70%
[01] |   levels(200/1) - 20.00%/18.00%
[02] |   |   entities(200/1) - 50.00%/9.00%
[03] |   |   |   minecraft:player(8000/40) - 60.00%/5.40%
[03] |   |   |   minecraft:bat(2000/10) - 10.00%/0.90%
[04] |   |   |   |   minecraft:player(400/2) - 5.00%/0.05%
[02] |   |   scheduledFunctions(200/1) - 10.00%/1.80%
[03] |   |   |   function sgp.kits:abilities/bats/check_for_explosion(5/0) - 80.00%/1.44%
[04] |   |   |   |   execute summon tnt ~ ~ ~ {Tags:["sgp.bat_grenade"]}(2000/10) - 50.00%/0.72%
[00] unspecified(200/1) - 0.00%/0.00%
[00] root total:0/200 average: 0/1
'''
        archive = directory / 'profile.zip'
        with zipfile.ZipFile(archive, 'w') as output:
            output.writestr('server/profiling.txt', text)
            output.writestr('server/metrics/jvm.csv', '@tick,heap MiB\n1,900.5\n2,1200.0\n3,850.25\n')
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
        self.assertAlmostEqual(profile.tick_percent, 90.0)
        self.assertAlmostEqual(profile.next_tick_wait_percent, 10.0)
        self.assertAlmostEqual(profile.mean_mspt_ms, 45.0)
        self.assertAlmostEqual(profile.command_functions_ms_per_tick, 4.5)
        self.assertEqual(profile.tick_periods_ms, [1.0, 2.0, 3.0, 4.0, 5.0])
        self.assertAlmostEqual(profile.tick_period_median_ms, 3.0)
        self.assertAlmostEqual(profile.tick_period_p95_ms, 5.0)
        self.assertAlmostEqual(profile.tick_period_max_ms, 5.0)
        self.assertAlmostEqual(profile.jvm_heap_min_mb, 850.25)
        self.assertAlmostEqual(profile.jvm_heap_max_mb, 1200.0)
        self.assertAlmostEqual(profile.commands_executed_per_tick, 40.0)
        self.assertAlmostEqual(profile.commands_prepared_per_tick, 0.0)
        self.assertAlmostEqual(profile.entities_percent, 9.0)
        self.assertAlmostEqual(profile.entities_ms_per_tick, 4.5)
        # The nested passenger occurrence of minecraft:player is not double counted.
        self.assertEqual(profile.entity_type_percent, {'minecraft:player': 5.4, 'minecraft:bat': 0.9})
        self.assertAlmostEqual(profile.entity_type_ms_per_tick()['minecraft:bat'], 0.45)
        self.assertEqual(len(profile.entries), 2)
        self.assertEqual(profile.entries[0].name, 'function minecraft:execute_repeating_functions')
        self.assertEqual(profile.entries[1].count, 8000)
        self.assertEqual(len(profile.scheduled_entries), 2)
        self.assertEqual(profile.scheduled_entries[0].name, 'function sgp.kits:abilities/bats/check_for_explosion')
        self.assertEqual(profile.scheduled_entries[1].count, 2000)
        serialized = bench.profile_to_dict(profile, {})
        self.assertEqual(serialized['scheduled_function_entries'][1]['count'], 2000)
        self.assertAlmostEqual(serialized['mean_mspt_ms'], 45.0)
        self.assertAlmostEqual(serialized['command_functions_ms_per_tick'], 4.5)
        self.assertAlmostEqual(serialized['tick_period_ms']['median'], 3.0)
        self.assertNotIn('tick_time_ms', serialized)
        self.assertAlmostEqual(serialized['commands_per_tick']['executed'], 40.0)
        self.assertAlmostEqual(serialized['jvm_heap_mb']['min'], 850.25)
        self.assertEqual(serialized['jvm_heap_mb']['samples'], 3)
        self.assertAlmostEqual(serialized['entities']['by_type_ms_per_tick']['minecraft:player'], 2.7)

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
