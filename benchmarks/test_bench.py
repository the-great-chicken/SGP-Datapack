from __future__ import annotations

from contextlib import redirect_stdout
from io import StringIO
from pathlib import Path
import importlib.util
import json
import sys
import tempfile
import unittest
from unittest.mock import patch
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


class ScenarioTests(unittest.TestCase):
    def test_atomic_scenario_parameters(self):
        scenarios = bench.load_scenarios()
        self.assertIn('idle', scenarios)
        production_abilities = {
            path.name
            for path in (ROOT / 'data/sgp.kits/function/abilities').iterdir()
            if path.is_dir()
        }
        expected_abilities = {f'ability_{name}' for name in production_abilities}
        self.assertTrue(expected_abilities <= scenarios.keys())
        # Base scenarios mirror the production ability directories, while
        # state-dependent high-cost paths are represented by additional variants.
        self.assertTrue(expected_abilities <= scenarios.keys())
        self.assertTrue({
            'ability_cooldown',
            'ability_pecking_miss',
            'ability_assassinate_triggered',
            'ability_bats_detonating',
            'ability_rays_dense',
            'ability_fangs_rough_terrain',
            'ability_tnt_batting',
        } <= scenarios.keys())
        self.assertTrue(
            any(
                path.parent != ROOT / 'benchmarks/scenarios'
                for path in (ROOT / 'benchmarks/scenarios').rglob('*.json')
                if json.loads(path.read_text(encoding='utf-8')).get('name') in expected_abilities
            ),
            'ability scenarios should exercise recursive scenario discovery',
        )
        self.assertIn('kits_idle', scenarios)
        self.assertIn('melee', scenarios)
        self.assertIn('cosmetic_smoke', scenarios)
        self.assertIn('diorama_giant', scenarios)
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
        _, params, plan = bench.resolve_plan(scenarios, 'idle', players=125)
        self.assertEqual(params['players'], 125)
        self.assertEqual(bench.plan_total_players(plan), 125)
        self.assertEqual((plan[0].first, plan[0].last), (1, 125))

    def test_benchmark_macro_commands_are_prefixed(self):
        fixture_root = ROOT / 'benchmarks/fixtures/data/sgp.bench/function'
        failures = []
        for path in fixture_root.rglob('*.mcfunction'):
            for line_number, line in enumerate(path.read_text(encoding='utf-8').splitlines(), 1):
                stripped = line.lstrip()
                if '$(' in line and stripped and not stripped.startswith('#') and not line.startswith('$'):
                    failures.append(f'{path.relative_to(ROOT)}:{line_number}: {line}')
        self.assertEqual(failures, [], 'benchmark macro commands need a leading $')

    def test_atomic_entrypoints_and_declared_counters_exist(self):
        scenarios = bench.load_scenarios()
        fixture_root = ROOT / 'benchmarks/fixtures/data'
        for scenario in scenarios.values():
            if 'components' in scenario:
                continue
            fixture_text = []
            entrypoint_dirs = set()
            for key in ('setup', 'tick', 'teardown'):
                namespace, path = scenario[key].split(':', 1)
                target = fixture_root / namespace / 'function' / f'{path}.mcfunction'
                self.assertTrue(target.is_file(), f'missing {target}')
                fixture_text.append(target.read_text(encoding='utf-8'))
                entrypoint_dirs.add(target.parent)
            for scenario_dir in entrypoint_dirs:
                fixture_text.extend(
                    path.read_text(encoding='utf-8')
                    for path in scenario_dir.glob('*.mcfunction')
                )
            combined = '\n'.join(fixture_text)
            for holder in scenario.get('counters', {}).values():
                self.assertIn(holder, combined, f'{scenario["name"]} never writes declared counter {holder}')

    def test_json_composition_assigns_disjoint_actor_ranges(self):
        scenarios = bench.load_scenarios()
        scenarios = {**scenarios, 'idle_cleave': {
            'name': 'idle_cleave',
            'description': 'test composition',
            'components': [
                {'scenario': 'idle', 'players': 20},
                {'scenario': 'ability_cleave', 'players': 20, 'parameters': {'period': 20}},
            ],
        }}
        bench.validate_scenario_graph(scenarios)
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

    def test_four_players_per_kit_composition_covers_every_ability(self):
        scenarios = bench.load_scenarios()
        selected, params, plan = bench.resolve_plan(scenarios, 'abilities_4_per_kit')
        self.assertEqual(selected['name'], 'abilities_4_per_kit')
        self.assertEqual(params, {})
        self.assertEqual(len(plan), 12)
        self.assertEqual(bench.plan_total_players(plan), 48)
        self.assertTrue(all(component.players == 4 for component in plan))
        self.assertEqual(
            {component.scenario for component in plan},
            {
                'ability_pecking',
                'ability_cleave',
                'ability_repulsion',
                'ability_fangs_rough_terrain',
                'ability_tnt_batting',
                'ability_bigger',
                'ability_rays_dense',
                'ability_smoke_grenade',
                'ability_illusions',
                'ability_assassinate_triggered',
                'ability_bats_detonating',
                'ability_water_trident',
            },
        )
        self.assertEqual((plan[0].first, plan[-1].last), (1, 48))

    def test_composition_has_no_framework_player_cap(self):
        scenarios = bench.load_scenarios()
        composite = {
            'name': 'large_composition',
            'description': 'test',
            'components': [
                {'scenario': 'idle', 'players': 60},
                {'scenario': 'ability_cleave', 'players': 65, 'parameters': {'period': 20}},
            ],
        }
        scenarios = {**scenarios, 'large_composition': composite}
        bench.validate_scenario_graph(scenarios)
        _, _, plan = bench.resolve_plan(scenarios, 'large_composition')
        self.assertEqual(bench.plan_total_players(plan), 125)
        self.assertEqual((plan[1].first, plan[1].last), (61, 125))

    def test_compile_active_plan_uses_component_ranges(self):
        scenarios = bench.load_scenarios()
        scenarios = {**scenarios, 'idle_cleave': {
            'name': 'idle_cleave',
            'description': 'test composition',
            'components': [
                {'scenario': 'idle', 'players': 20},
                {'scenario': 'ability_cleave', 'players': 20, 'parameters': {'period': 20}},
            ],
        }}
        bench.validate_scenario_graph(scenarios)
        _, _, plan = bench.resolve_plan(scenarios, 'idle_cleave')
        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary)
            bench.compile_active_plan(server, plan)
            active = server / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/generated/active'
            setup = (active / 'setup.mcfunction').read_text(encoding='utf-8')
            tick = (active / 'tick.mcfunction').read_text(encoding='utf-8')
            teardown = (active / 'teardown.mcfunction').read_text(encoding='utf-8')
            measurement_reset = (active / 'measurement_reset.mcfunction').read_text(encoding='utf-8')
        self.assertIn('function sgp.bench:scenarios/idle/setup {first:1,last:20,players:20}', setup)
        self.assertIn(
            'function sgp.bench:scenarios/abilities/cleave/setup '
            '{first:21,last:40,players:20,period:20}',
            setup,
        )
        self.assertIn(
            'function sgp.bench:scenarios/abilities/cleave/tick '
            '{first:21,last:40,players:20,period:20}',
            tick,
        )
        self.assertTrue(teardown.index('abilities/cleave/teardown') < teardown.index('idle/teardown'))
        self.assertIn('scoreboard players set #cleave_drop_inputs sgp.bench 0', measurement_reset)
        self.assertIn('scoreboard players set #cleave_waves sgp.bench 0', measurement_reset)


    def test_repeated_atomic_scenario_aggregates_same_counter(self):
        scenarios = bench.load_scenarios()
        composite = {
            'name': 'two_cleave_groups',
            'description': 'test',
            'components': [
                {'scenario': 'ability_cleave', 'players': 10, 'parameters': {'period': 10}},
                {'scenario': 'ability_cleave', 'players': 10, 'parameters': {'period': 20}},
            ],
        }
        scenarios = {**scenarios, 'two_cleave_groups': composite}
        bench.validate_scenario_graph(scenarios)
        _, _, plan = bench.resolve_plan(scenarios, 'two_cleave_groups')
        self.assertEqual(bench.plan_counter_specs(plan), {
            'ability_cleave.drop_inputs': '#cleave_drop_inputs',
            'ability_cleave.waves': '#cleave_waves',
        })


    def test_actor_pool_resize_cleans_previous_larger_pool_once(self):
        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary)
            actors = server / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/actors'
            actors.mkdir(parents=True)
            (server / 'server.properties').write_text('level-name=world\n', encoding='utf-8')

            bench.compile_actor_pool(server, 73)
            bench.compile_actor_pool(server, 12)
            cleanup = (actors / 'cleanup.mcfunction').read_text(encoding='utf-8')
            spawn = (actors / 'spawn.mcfunction').read_text(encoding='utf-8')
            self.assertIn('Bench73', cleanup)
            self.assertNotIn('Bench13', spawn)
            self.assertEqual((server / '.sgp-benchmark-actor-count').read_text().strip(), '12')

            bench.compile_actor_pool(server, 12)
            cleanup = (actors / 'cleanup.mcfunction').read_text(encoding='utf-8')
            self.assertNotIn('Bench73', cleanup)

    def test_stateful_ability_stress_models_cover_expensive_paths(self):
        fixtures = ROOT / 'benchmarks/fixtures/data/sgp.bench/function'

        cleave_setup = (fixtures / 'scenarios/abilities/cleave/setup.mcfunction').read_text(encoding='utf-8')
        self.assertIn('18.5 81 -30.5', cleave_setup)
        self.assertIn('18.5 81 -26.5', cleave_setup)
        self.assertIn('knockback_resistance', cleave_setup)

        water_fire = (fixtures / 'scenarios/abilities/water_trident/fire.mcfunction').read_text(encoding='utf-8')
        water_tick = (fixtures / 'scenarios/abilities/water_trident/tick.mcfunction').read_text(encoding='utf-8')
        self.assertNotIn('reset_water', water_fire)
        self.assertNotIn('remove_riptide', water_fire)
        self.assertIn('leave_water', water_tick)
        self.assertIn('return_home', water_tick)

        repulsion_tick = (fixtures / 'scenarios/abilities/repulsion/tick.mcfunction').read_text(encoding='utf-8')
        self.assertIn('sgp.bench.clock=12', repulsion_tick)
        self.assertIn('reset_actor_position', repulsion_tick)

        rough = (fixtures / 'terrain/vertical_stress_lane/build.mcfunction').read_text(encoding='utf-8')
        self.assertGreaterEqual(rough.count('fill '), 5)
        self.assertIn('stone_slab[type=bottom]', rough)

    def test_diorama_giant_benchmark_uses_production_tick_and_hover_cache(self):
        scenarios = bench.load_scenarios()
        scenario = scenarios['diorama_giant']
        self.assertEqual(scenario['parameters']['buttons']['default'], 16)
        self.assertEqual(scenario['parameters']['buttons']['max'], 16)

        fixtures = ROOT / 'benchmarks/fixtures/data/sgp.bench/function/scenarios/systems/diorama_giant'
        setup = (fixtures / 'setup.mcfunction').read_text(encoding='utf-8')
        seed = (fixtures / 'seed_buttons.mcfunction').read_text(encoding='utf-8')
        tick_path = fixtures / 'tick.mcfunction'
        teardown = (fixtures / 'teardown.mcfunction').read_text(encoding='utf-8')

        self.assertIn('function sgp.diorama:init/markers', setup)
        self.assertIn('function sgp.diorama:spawn_entities/clear_and_recreate', setup)
        self.assertIn('scoreboard players set #diorama_enabled sgp.dummy 1', setup)
        self.assertIn('function sgp.diorama:tick/main', setup)
        self.assertIn('team modify sgpbenchdio collisionRule never', setup)
        self.assertIn('function sgp.bench:scenarios/systems/diorama_giant/position', setup)
        self.assertIn('summon marker 16 160 16', setup)
        self.assertIn('summon marker 0 121 0', setup)
        self.assertEqual(seed.count('.list append value'), 16)
        self.assertEqual(list(bench.logical_commands(tick_path)), [])
        self.assertIn('scoreboard players set #diorama_enabled sgp.dummy 0', teardown)
        self.assertIn('function sgp.diorama:cleanup_player', teardown)

    def test_same_tick_tnt_and_bat_detonations_are_idempotent(self):
        tnt_dispatch = (ROOT / 'data/sgp.kits/function/abilities/tnt/explode_at.mcfunction').read_text(encoding='utf-8')
        tnt_fire = (ROOT / 'data/sgp.kits/function/abilities/tnt/summon_fire.mcfunction').read_text(encoding='utf-8')
        self.assertIn('tag=!sgp.tnt_fire_spawned', tnt_dispatch)
        self.assertIn('tag @s add sgp.tnt_fire_spawned', tnt_fire)

        bat_scan = (ROOT / 'data/sgp.kits/function/abilities/bats/check_for_explosion.mcfunction').read_text(encoding='utf-8')
        bat_explode = (ROOT / 'data/sgp.kits/function/abilities/bats/explode.mcfunction').read_text(encoding='utf-8')
        self.assertIn('tag=!sgp.bat_detonated', bat_scan)
        self.assertIn('tag @s add sgp.bat_detonated', bat_explode)
        self.assertIn('tag=sgp.bat_detonated', bat_explode)


class SuiteTests(unittest.TestCase):
    def test_basic_scaling_expands_to_eight_cases(self):
        _path, suite = bench.load_suite('basic_scaling')
        cases = bench.expand_suite_cases(suite, bench.load_scenarios())
        self.assertEqual(len(cases), 8)
        self.assertEqual(
            [(case['scenario'], case['players']) for case in cases[:4]],
            [('idle', 1), ('idle', 10), ('idle', 20), ('idle', 40)],
        )
        self.assertEqual(
            [(case['scenario'], case['players'], case['parameters']) for case in cases[4:]],
            [
                ('ability_cleave', 1, {'period': 20}),
                ('ability_cleave', 10, {'period': 20}),
                ('ability_cleave', 20, {'period': 20}),
                ('ability_cleave', 40, {'period': 20}),
            ],
        )
        self.assertTrue(all(case['runs'] == 5 for case in cases))
        self.assertTrue(all(case['warmup'] == 5.0 for case in cases))

    def test_tnt_batting_uses_real_packtest_attack_and_bedrock_arena(self):
        batting = (
            ROOT / 'benchmarks/fixtures/data/sgp.bench/function/scenarios/abilities/tnt_batting/bat.mcfunction'
        ).read_text(encoding='utf-8')
        setup = (
            ROOT / 'benchmarks/fixtures/data/sgp.bench/function/fixture/setup.mcfunction'
        ).read_text(encoding='utf-8')
        self.assertIn('dummy @s attack @n[tag=sgp.tnt_interaction', batting)
        self.assertIn('fill -32 80 -32 32 80 32 minecraft:bedrock', setup)
        self.assertNotIn('fill -32 80 -32 32 80 32 minecraft:stone', setup)

    def test_all_abilities_suite_covers_every_atomic_ability(self):
        _path, suite = bench.load_suite('all_abilities')
        scenarios = bench.load_scenarios()
        cases = bench.expand_suite_cases(suite, scenarios)
        expected = {name for name in scenarios if name.startswith('ability_')}
        self.assertEqual(len(cases), 19)
        self.assertEqual({case['scenario'] for case in cases}, expected)
        self.assertTrue(all(case['players'] == 40 for case in cases))

    def test_diorama_scaling_separates_mannequin_and_hover_costs(self):
        _path, suite = bench.load_suite('diorama_scaling')
        cases = bench.expand_suite_cases(suite, bench.load_scenarios())
        self.assertEqual(len(cases), 8)
        self.assertTrue(all(case['scenario'] == 'diorama_giant' for case in cases))
        self.assertEqual(
            [(case['players'], case['parameters']) for case in cases[:4]],
            [(1, {'buttons': 0}), (8, {'buttons': 0}), (20, {'buttons': 0}), (50, {'buttons': 0})],
        )
        self.assertEqual(
            [(case['players'], case['parameters']) for case in cases[4:]],
            [(1, {'buttons': 16}), (8, {'buttons': 16}), (20, {'buttons': 16}), (50, {'buttons': 16})],
        )

    def test_matrix_is_cartesian_product(self):
        suite = {
            'name': 'cartesian',
            'description': 'test',
            'defaults': {'runs': 2, 'warmup': 1},
            'benchmarks': [{
                'scenario': 'ability_cleave',
                'matrix': {'players': [10, 20], 'period': [10, 20]},
            }],
        }
        cases = bench.expand_suite_cases(suite, bench.load_scenarios())
        self.assertEqual(
            [(case['players'], case['parameters']['period']) for case in cases],
            [(10, 10), (10, 20), (20, 10), (20, 20)],
        )


class StagingTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.prepare_bench = load_prepare_bench()

    def test_stage_is_plugin_free_and_contains_benchmark_overlay(self):
        with tempfile.TemporaryDirectory() as temporary:
            server = Path(temporary) / 'server'
            staged_scenarios = self.prepare_bench.load_scenarios(ROOT)
            self.assertIn('ability_water_trident', staged_scenarios)
            self.assertIn('abilities_4_per_kit', staged_scenarios)
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

            spawn_path = data / 'sgp.bench/function/actors/spawn.mcfunction'
            cleanup_path = data / 'sgp.bench/function/actors/cleanup.mcfunction'
            self.assertIn('Generated into the staged datapack', spawn_path.read_text(encoding='utf-8'))
            self.assertIn('Generated into the staged datapack', cleanup_path.read_text(encoding='utf-8'))

            bench.compile_actor_pool(server, 73)
            spawn = spawn_path.read_text(encoding='utf-8')
            cleanup = cleanup_path.read_text(encoding='utf-8')
            self.assertEqual(spawn.count(' sgp.id '), 73)
            self.assertIn('scoreboard players set Bench01 sgp.id 1', spawn)
            self.assertIn('scoreboard players set Bench73 sgp.id 73', spawn)
            self.assertNotIn('Bench74', spawn)
            self.assertIn('scoreboard players reset Bench73\n', cleanup)
            self.assertIn('data remove storage sgp.kits:stats kits_dict.73', cleanup)
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
            self.assertIn('max-players=74', properties)

            placeholder = data / 'sgp.bench/function/generated/active/setup.mcfunction'
            self.assertTrue(placeholder.is_file())
            self.assertIn('#plan_ready', placeholder.read_text(encoding='utf-8'))
            measurement_placeholder = data / 'sgp.bench/function/generated/active/measurement_reset.mcfunction'
            self.assertTrue(measurement_placeholder.is_file())
            measurement_reset = (data / 'sgp.bench/function/measurement_reset.mcfunction').read_text(encoding='utf-8')
            self.assertIn('function sgp.bench:generated/active/measurement_reset', measurement_reset)
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
            'status': 'complete',
            'runs': 3,
            'plan': [],
            'command_limit': 65536,
        }), encoding='utf-8')
        for i in range(1, 4):
            (path / f'run-{i:02d}.json').write_text(json.dumps({
                'tick_span': 200,
                'effective_tps': 20.0,
                'tick_time_ms': {'median': 4.0, 'p95': 8.0, 'max': 12.0},
                'command_functions_percent': command_percent,
                'harness_counters_after_profile_write': {
                    'ticks': 201,
                    'workload': {'ability_cleave.drop_inputs': 400, 'ability_cleave.waves': 10},
                },
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
        self.assertIn('ability_cleave.drop_inputs', text)


class WorkloadIntegrityTests(unittest.TestCase):
    limit_line = '[Server thread/INFO]: Command execution stopped due to limit (executed 65536 commands)'

    def server(self):
        return bench.ServerProcess(Path('unused'), 'unused-java', '2G')

    def test_limit_failure_is_sticky_and_precedes_successful_response(self):
        server = self.server()
        server.lines.extend([self.limit_line, 'Done (1.0s)! For help, type help'])
        for _ in range(2):
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, '65536'):
                server.wait_for(lambda line: 'Done (' in line, 0, start_at=1)

    def test_limit_arriving_after_an_earlier_health_check_is_detected(self):
        server = self.server()
        server.lines.append('normal output')
        server.check_health()
        server.lines.append(self.limit_line)
        with self.assertRaises(bench.BenchmarkInvalidError):
            server.sleep_alive(0)

    def test_score_does_not_swallow_command_limit_failure(self):
        server = self.server()
        def respond(command):
            server.lines.extend([self.limit_line, '#players has 40 [sgp.bench]'])
        with patch.object(server, 'send', side_effect=respond):
            with self.assertRaises(bench.BenchmarkInvalidError):
                server.score('#players')

    def test_profile_wait_aborts_before_accepting_an_archive(self):
        server = self.server()
        server.lines.append(self.limit_line)
        with tempfile.TemporaryDirectory() as temporary:
            with self.assertRaises(bench.BenchmarkInvalidError):
                bench.wait_for_new_profile(Path(temporary), set(), server, timeout=1)

    def ray_run(self, players=40, ticks=200):
        return {
            'tick_span': ticks,
            'harness_counters_after_profile_write': {'workload': {'ability_rays.active_player_ticks': players*ticks}},
            'command_function_entries': [
                {'name': 'execute tag @s remove sgp.radiator', 'count': players*ticks},
                {'name': 'execute scoreboard players set #ray_dist sgp.dummy 16000', 'count': players*ticks*8},
                {'name': 'execute execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players remove @s sgp.timer 2', 'count': players*ticks*8},
            ],
        }

    def test_complete_rays_profile_validates_all_composed_ray_players(self):
        plan = [{'scenario': 'ability_rays', 'players': 25}, {'scenario': 'ability_rays_dense', 'players': 15},
                {'scenario': 'idle', 'players': 10}]
        self.assertEqual(bench.validate_ray_workload(self.ray_run(), plan),
                         {'ray_player_ticks': 8000, 'ray_beam_updates': 64000})

    def test_exposure_does_not_mask_missing_or_excess_completed_work(self):
        plan = [{'scenario': 'ability_rays', 'players': 40}]
        for entry_index, count in [(0, 2400), (1, 20600), (2, 20400), (2, 64001)]:
            with self.subTest(entry_index=entry_index, count=count):
                run = self.ray_run()
                run['command_function_entries'][entry_index]['count'] = count
                with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'Incomplete rays workload'):
                    bench.validate_ray_workload(run, plan)

    def test_missing_ray_entries_or_tick_span_cannot_validate(self):
        plan = [{'scenario': 'ability_rays', 'players': 40}]
        for run in [{'tick_span': 200, 'command_function_entries': []}, self.ray_run(ticks=0)]:
            with self.assertRaises(bench.BenchmarkInvalidError):
                bench.validate_ray_workload(run, plan)
        self.assertEqual(bench.validate_ray_workload({}, [{'scenario': 'idle', 'players': 40}]), {})

    def test_command_limit_is_explicit_for_runs_and_suites(self):
        parser = bench.build_parser()
        self.assertEqual(parser.parse_args(['run', 'ability_rays']).command_limit, 65536)
        self.assertEqual(parser.parse_args(['run', 'ability_rays', '--command-limit', '1000000']).command_limit, 1000000)
        self.assertEqual(parser.parse_args(['suite', 'all_abilities', '--command-limit', '1000000']).command_limit, 1000000)
        for value in ['0', '-1', '2147483648']:
            with self.assertRaises(bench.argparse.ArgumentTypeError):
                bench.command_limit_argument(value)

    def test_ray_entity_checks_reject_missing_beams_and_leftovers_after_reset(self):
        server = self.server()
        plan = [{'scenario': 'ability_rays', 'players': 40}]
        with patch.object(server, 'send'), patch.object(server, 'score', return_value=320):
            bench.require_ray_entities(server, plan)
        with patch.object(server, 'send'), patch.object(server, 'score', return_value=0):
            bench.require_ray_entities(server, plan, after_reset=True)
        for actual, after_reset in [(104, False), (321, False), (1, True), (None, False)]:
            with self.subTest(actual=actual, after_reset=after_reset), \
                 patch.object(server, 'send'), patch.object(server, 'score', return_value=actual):
                with self.assertRaises(bench.BenchmarkInvalidError):
                    bench.require_ray_entities(server, plan, after_reset=after_reset)

    def test_diorama_profile_requires_one_update_per_player_per_tick(self):
        plan = [{'scenario': 'diorama_giant', 'players': 50}, {'scenario': 'idle', 'players': 10}]
        run = {'tick_span': 201, 'command_function_entries': [
            {'name': 'execute scoreboard players set @s bs.ttl 100', 'count': 10050},
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
        helper = ComparisonTests()
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root/'before', root/'after'
            helper.write_result(before, 8.0, 5.0)
            helper.write_result(after, 6.0, 3.0)
            path = after/'metadata.json'
            metadata = json.loads(path.read_text())
            metadata['plan'] = [{'scenario': 'diorama_giant', 'players': 50}]
            path.write_text(json.dumps(metadata))
            args = bench.build_parser().parse_args(['compare', str(before), str(after), '--allow-mismatch'])
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'Incomplete Diorama workload'):
                bench.compare_results(args)

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
            with patch.object(bench, 'prepare_server', side_effect=prepare), \
                 patch.object(bench, 'ServerProcess', InterruptedServer), \
                 patch.object(bench, 'git_commit', return_value=None), \
                 patch.object(bench, 'source_fingerprint', return_value='test-source'), \
                 redirect_stdout(StringIO()):
                with self.assertRaises(bench.BenchmarkInvalidError):
                    bench.run_benchmark(args)
            result = next((root/'results').iterdir())
            metadata = json.loads((result/'metadata.json').read_text())
            self.assertEqual(metadata['status'], 'failed')
            self.assertEqual(metadata['command_limit'], 1000000)
            self.assertTrue((result/'failure.json').is_file())
            self.assertFalse((result/'summary.md').exists())
            self.assertTrue((root/'server'/bench.INVALID_MARKER).is_file())
            self.assertEqual(commands.count('function sgp.bench:start'), 1)
            self.assertNotIn('perf start', commands)
            self.assertEqual(commands[-1], 'stop')

    def test_comparison_rejects_failed_incomplete_or_mismatched_results(self):
        helper = ComparisonTests()
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            before, after = root/'before', root/'after'
            helper.write_result(before, 8.0, 5.0)
            helper.write_result(after, 6.0, 3.0)
            args = bench.build_parser().parse_args(['compare', str(before), str(after)])
            path = after/'metadata.json'
            original = json.loads(path.read_text())
            for change in [{'status': 'failed'}, {'runs': 4}, {'command_limit': 1000000}]:
                path.write_text(json.dumps({**original, **change}))
                with self.assertRaises(bench.BenchmarkError):
                    bench.compare_results(args)
            path.write_text(json.dumps({**original, 'plan': [{'scenario': 'ability_rays', 'players': 40}]}))
            args.allow_mismatch = True
            with self.assertRaisesRegex(bench.BenchmarkInvalidError, 'Incomplete rays workload'):
                bench.compare_results(args)


if __name__ == '__main__':
    unittest.main()
