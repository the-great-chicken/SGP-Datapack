from .common import *

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
