import unittest

from common import ROOT


class StatsCollectorContracts(unittest.TestCase):
    def test_boundary_tests_invoke_the_public_entrypoints_they_cover(self):
        tests = ROOT / 'data/sgp.kits/test/stats_collector/entrypoints'
        required_calls = {
            'ability_lifecycle': [
                'function sgp.kits:stats_collector/ability/start',
                'function sgp.kits:stats_collector/ability/mark_affected',
                'function sgp.kits:stats_collector/ability/mark_success',
                'function sgp.kits:stats_collector/ability/tank_hit',
            ],
            'kill_attribution': ['function sgp.kits:stats_collector/collect_kill_infos'],
            'kit_pick': ['function sgp.kits:stats_collector/collect_kit_pick_infos'],
            'death_position': ['function sgp.kits:stats_collector/death_position/capture'],
            'elo_real_death': ['function sgp.kits:stats_collector/elo/on_real_death'],
        }
        forbidden_helpers = {
            'kill_attribution': 'function sgp.kits:stats_collector/save_kill_cause_stat',
            'kit_pick': 'function sgp.kits:stats_collector/save_pick_start',
            'death_position': 'function sgp.kits:stats_collector/death_position/save',
        }
        for name, calls in required_calls.items():
            path = tests / f'{name}.mcfunction'
            self.assertTrue(path.is_file(), path)
            text = path.read_text(encoding='utf-8')
            for call in calls:
                self.assertIn(call, text, path)
            if name in forbidden_helpers:
                self.assertNotIn(forbidden_helpers[name], text, path)

    def test_rays_damage_uses_specialized_stats_fast_path(self):
        collector = (ROOT / 'data/sgp.kits/function/stats_collector/collect_ray_damage_received_valid.mcfunction').read_text(encoding='utf-8')
        marker = (ROOT / 'data/sgp.kits/function/stats_collector/ability/mark_ray_affected.mcfunction').read_text(encoding='utf-8')

        self.assertIn('function sgp.kits:stats_collector/save_damage_received', collector)
        self.assertIn('store result score #ray_ability_cast sgp.dummy', collector)
        self.assertIn('if score @s sgp.ability_kind matches 6', collector)
        self.assertIn('if score @s sgp.ability_cast matches 1..', collector)
        self.assertIn('function sgp.kits:stats_collector/ability/mark_ray_affected', collector)
        self.assertNotIn('sgp.ability_damage_target', collector)
        self.assertNotIn('function sgp.kits:stats_collector/ability/route_damage', collector)

        self.assertIn('sgp.last_ability_cast = #ray_ability_cast sgp.dummy', marker)
        self.assertIn('execute on attacker run function sgp.kits:stats_collector/ability/mark_success', marker)
        self.assertIn('execute on attacker run function sgp.kits:stats_collector/ability/increment', marker)
