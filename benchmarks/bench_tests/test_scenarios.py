from .common import *
from benchmarks.harness.validators import validators_for_names, validators_for_plan

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

    def test_invalid_counter_declarations_are_rejected(self):
        scenarios = bench.load_scenarios()
        atomic_name = next(name for name, value in scenarios.items() if 'components' not in value)
        invalid = {name: dict(value) for name, value in scenarios.items()}
        invalid[atomic_name] = {**invalid[atomic_name], 'counters': {'bad counter': 'not-a-scoreholder'}}
        with self.assertRaisesRegex(bench.BenchmarkError, 'invalid counter name'):
            bench.validate_scenario_graph(invalid)

    def test_scenario_validators_are_data_driven_and_composition_safe(self):
        scenarios = bench.load_scenarios()

        _, _, rays = bench.resolve_plan(scenarios, 'ability_rays', players=4)
        self.assertEqual(rays[0].validators, ('rays',))
        self.assertEqual([validator.name for validator in validators_for_plan(rays)], ['rays'])

        _, _, diorama = bench.resolve_plan(scenarios, 'diorama_giant', players=4)
        self.assertEqual(diorama[0].validators, ('diorama',))

        _, _, mixed = bench.resolve_plan(scenarios, 'abilities_4_per_kit')
        self.assertEqual([validator.name for validator in validators_for_plan(mixed)], ['rays'])

        with self.assertRaisesRegex(bench.BenchmarkError, 'Unknown benchmark scenario validator'):
            validators_for_names(['does-not-exist'])

        invalid_composite = {
            **scenarios,
            'invalid_composite': {
                'name': 'invalid_composite',
                'description': 'validators must be attached to atomic workloads',
                'validators': ['rays'],
                'components': [{'scenario': 'idle'}],
            },
        }
        with self.assertRaisesRegex(bench.BenchmarkError, 'validators belong on atomic scenarios'):
            bench.validate_scenario_graph(invalid_composite)
