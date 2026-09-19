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
