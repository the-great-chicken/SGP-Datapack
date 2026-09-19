from .common import *

class SuiteTests(unittest.TestCase):


    def test_all_abilities_suite_covers_every_atomic_ability(self):
        _path, suite = bench.load_suite('all_abilities')
        scenarios = bench.load_scenarios()
        cases = bench.expand_suite_cases(suite, scenarios)
        expected = {name for name in scenarios if name.startswith('ability_')}
        self.assertEqual(len(cases), 19)
        self.assertEqual({case['scenario'] for case in cases}, expected)
        self.assertTrue(all(case['players'] == 40 for case in cases))

    def test_diorama_scaling_pairs_each_player_count_with_and_without_hover_ui(self):
        _path, suite = bench.load_suite('diorama_scaling')
        cases = bench.expand_suite_cases(suite, bench.load_scenarios())
        self.assertTrue(cases)
        self.assertTrue(all(case['scenario'] == 'diorama_giant' for case in cases))
        by_players = {}
        for case in cases:
            by_players.setdefault(case['players'], set()).add(case['parameters'].get('buttons'))
        self.assertTrue(by_players)
        self.assertTrue(all(buttons == {0, 16} for buttons in by_players.values()))


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
