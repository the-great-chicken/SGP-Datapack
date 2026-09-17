from __future__ import annotations

from contextlib import redirect_stdout
from io import StringIO
from pathlib import Path
import importlib.util
import json
import sys
import tempfile
import unittest
import zipfile

import bench


ROOT = Path(__file__).resolve().parent.parent


def load_prepare_bench():
    path = ROOT / '.github/scripts/prepare_bench.py'
    spec = importlib.util.spec_from_file_location('test_prepare_bench', path)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    try:
        spec.loader.exec_module(module)
    except Exception:
        sys.modules.pop(spec.name, None)
        raise
    return module


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

    def test_logical_commands_joins_continuations_and_ignores_macros(self):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'x.mcfunction'
            path.write_text(
                '# comment\nexecute as @a \\\n    at @s run say hello\n$scoreboard players set @s foo $(value)\n',
                encoding='utf-8',
            )
            commands = list(bench.logical_commands(path))
        self.assertEqual(commands, [(2, 'execute as @a at @s run say hello')])


class ScenarioTests(unittest.TestCase):
    def test_atomic_scenario_parameters(self):
        scenarios = bench.load_scenarios()
        self.assertIn('idle', scenarios)
        self.assertIn('ability_cleave', scenarios)
        self.assertNotIn('mixed', scenarios)
        selected, params, plan = bench.resolve_plan(
            scenarios, 'ability_cleave', players=12, raw_params=['period=30']
        )
        self.assertEqual(selected['name'], 'ability_cleave')
        self.assertEqual(params, {'players': 12, 'period': 30})
        self.assertEqual(len(plan), 1)
        self.assertEqual(plan[0].scenario, 'ability_cleave')
        self.assertEqual((plan[0].first, plan[0].last), (1, 12))
        self.assertEqual(plan[0].parameters, {'period': 30})
        with self.assertRaises(bench.BenchmarkError):
            bench.resolve_plan(scenarios, 'idle', players=41)

    def test_json_composition_assigns_disjoint_actor_ranges(self):
        scenarios = bench.load_scenarios()
        selected, params, plan = bench.resolve_plan(scenarios, 'idle_cleave')
        self.assertEqual(selected['name'], 'idle_cleave')
        self.assertEqual(params, {})
        self.assertEqual(bench.plan_total_players(plan), 40)
        self.assertEqual(
            [(item.scenario, item.players, item.first, item.last, item.parameters) for item in plan],
            [
                ('idle', 20, 1, 20, {}),
                ('ability_cleave', 20, 21, 40, {'period': 20}),
            ],
        )

    def test_compile_active_plan_uses_component_ranges(self):
        scenarios = bench.load_scenarios()
        _, _, plan = bench.resolve_plan(scenarios, 'idle_cleave')
        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary)
            bench.compile_active_plan(server, plan)
            active = server / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/generated/active'
            setup = (active / 'setup.mcfunction').read_text(encoding='utf-8')
            tick = (active / 'tick.mcfunction').read_text(encoding='utf-8')
            teardown = (active / 'teardown.mcfunction').read_text(encoding='utf-8')
        self.assertIn('function sgp.bench:scenarios/idle/setup {first:1,last:20,players:20}', setup)
        self.assertIn(
            'function sgp.bench:scenarios/ability_cleave/setup '
            '{first:21,last:40,players:20,period:20}',
            setup,
        )
        self.assertIn(
            'function sgp.bench:scenarios/ability_cleave/tick '
            '{first:21,last:40,players:20,period:20}',
            tick,
        )
        self.assertTrue(teardown.index('ability_cleave/teardown') < teardown.index('idle/teardown'))


class StagingTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.prepare_bench = load_prepare_bench()

    def test_stage_is_plugin_free_and_contains_benchmark_overlay(self):
        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary) / 'server'
            self.prepare_bench.prepare(ROOT, server)
            self.assertTrue((server / '.sgp-benchmark-server').is_file())
            data = server / 'world/datapacks/SGP-Datapack/data'
            self.assertFalse((data / 'sgp.integration.discord').exists())
            self.assertFalse((data / 'sgp.integration.tab').exists())
            self.assertFalse((data / 'sgp.integration.tgc').exists())
            self.assertFalse((data / 'sgp.kits/test').exists())
            self.assertTrue((data / 'sgp.bench/function/tick.mcfunction').is_file())

            # Benchmark staging must retain production resources rather than the
            # deterministic PackTest unit-test overlays used by prepare_core.py.
            production_loot = ROOT / 'data/sgp.mineurs/loot_table/lootdrop_chest.json'
            staged_loot = data / 'sgp.mineurs/loot_table/lootdrop_chest.json'
            self.assertEqual(staged_loot.read_bytes(), production_loot.read_bytes())

            spawn = (data / 'sgp.bench/function/actors/spawn.mcfunction').read_text(encoding='utf-8')
            cleanup = (data / 'sgp.bench/function/actors/cleanup.mcfunction').read_text(encoding='utf-8')
            self.assertEqual(spawn.count(' sgp.id '), 40)
            self.assertIn('scoreboard players set Bench01 sgp.id 1', spawn)
            self.assertIn('scoreboard players set Bench40 sgp.id 40', spawn)
            self.assertIn('scoreboard players reset Bench01\n', cleanup)
            self.assertIn('data remove storage sgp.kits:stats kits_dict.40', cleanup)
            self.assertIn('sgp.bench:actors/remove_mixer_registration', cleanup)
            mixer_cleanup = (data / 'sgp.bench/function/actors/remove_mixer_uid.mcfunction').read_text(encoding='utf-8')
            self.assertIn('data remove storage dah:actbar', mixer_cleanup)

            tick_tag = json.loads((data / 'minecraft/tags/function/tick.json').read_text(encoding='utf-8'))
            load_tag = json.loads((data / 'minecraft/tags/function/load.json').read_text(encoding='utf-8'))
            self.assertIn('sgp.bench:tick', tick_tag['values'])
            self.assertIn('sgp.bench:load', load_tag['values'])

            fixture = (data / 'sgp.bench/function/fixture/setup.mcfunction').read_text(encoding='utf-8')
            self.assertIn('gamerule minecraft:spawn_mobs false', fixture)
            self.assertIn('gamerule minecraft:advance_weather false', fixture)
            self.assertIn('gamerule minecraft:advance_time false', fixture)
            self.assertIn('gamerule minecraft:fire_spread_radius_around_player 0', fixture)
            self.assertNotIn('doMobSpawning', fixture)
            self.assertNotIn('doWeatherCycle', fixture)
            self.assertNotIn('doDaylightCycle', fixture)
            self.assertNotIn('doFireTick', fixture)
            self.assertIn('scoreboard players set #fixture_ready sgp.bench 1', fixture)
            properties = (server / 'server.properties').read_text(encoding='utf-8')
            self.assertIn('level-type=minecraft:flat', properties)
            self.assertIn('spawn-monsters=false', properties)

            placeholder = data / 'sgp.bench/function/generated/active/setup.mcfunction'
            self.assertTrue(placeholder.is_file())
            self.assertIn('#plan_ready', placeholder.read_text(encoding='utf-8'))
            self.assertFalse((data / 'sgp.bench/function/dispatch.mcfunction').exists())


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


class ComparisonTests(unittest.TestCase):
    def write_result(self, path: Path, command_percent: float, entry_percent: float):
        path.mkdir()
        (path / 'metadata.json').write_text(json.dumps({
            'scenario': 'idle',
            'parameters': {'players': 40},
        }), encoding='utf-8')
        for i in range(1, 4):
            (path / f'run-{i:02d}.json').write_text(json.dumps({
                'tick_span': 200,
                'effective_tps': 20.0,
                'tick_time_ms': {'median': 4.0, 'p95': 8.0, 'max': 12.0},
                'command_functions_percent': command_percent,
                'harness_counters_after_profile_write': {'ticks': 201, 'actions': 0},
                'command_function_entries': [{
                    'name': 'function minecraft:execute_repeating_functions',
                    'count': 200,
                    'global_percent': entry_percent,
                }],
            }), encoding='utf-8')

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


if __name__ == '__main__':
    unittest.main()
