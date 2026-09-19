import json
import re
import unittest

from common import ROOT


class DeathCauseContracts(unittest.TestCase):
    def test_death_cause_resources_are_exhaustive_and_unambiguous(self):
        functions = ROOT / 'data/sgp.kits/function/stats_collector/death_cause'
        advancements = ROOT / 'data/sgp.kits/advancement/death_cause'
        tags = ROOT / 'data/sgp.kits/tags/damage_type/death_cause'

        function_ids = {}
        for path in sorted(functions.glob('*.mcfunction')):
            text = path.read_text(encoding='utf-8')
            match = re.search(r'scoreboard players set @s sgp\.death_cause (-?\d+)', text)
            self.assertIsNotNone(match, path)
            function_ids[path.stem] = int(match.group(1))
            self.assertIn('function sgp.kits:stats_collector/collect_damage_received', text, path)
        self.assertEqual(len(set(function_ids.values())), len(function_ids), 'death-cause ids must be unique')

        init = (ROOT / 'data/sgp.kits/function/stats_collector/init.mcfunction').read_text(encoding='utf-8')
        match = re.search(r'damage_cause_names set value (\{[^\n]+\})', init)
        self.assertIsNotNone(match)
        metadata = {name: int(cause_id) for cause_id, name in json.loads(match.group(1)).items()}
        self.assertEqual(function_ids, metadata)

        concrete_members = {}
        for name in sorted(function_ids):
            advancement = json.loads((advancements / f'{name}.json').read_text(encoding='utf-8'))
            self.assertEqual(advancement['rewards']['function'], f'sgp.kits:stats_collector/death_cause/{name}')
            condition = advancement['criteria']['track']['conditions']['damage']['type']['tags']
            if name == 'unknown':
                self.assertEqual(condition, [{'id': 'sgp.kits:death_cause/known', 'expected': False}])
                continue
            self.assertEqual(condition, [{'id': f'sgp.kits:death_cause/{name}', 'expected': True}])
            tag = json.loads((tags / f'{name}.json').read_text(encoding='utf-8'))
            for value in tag['values']:
                if value.startswith('#'):
                    continue
                self.assertNotIn(value, concrete_members, f'{value} belongs to multiple death causes')
                concrete_members[value] = name

        known = json.loads((tags / 'known.json').read_text(encoding='utf-8'))['values']
        expected_known = {f'#sgp.kits:death_cause/{name}' for name in function_ids if name != 'unknown'}
        self.assertEqual(set(known), expected_known)
        self.assertEqual(len(known), len(expected_known))

        runtime_tests = sorted((ROOT / 'data/sgp.kits/test/stats_collector/death_cause').glob('*.mcfunction'))
        combined = '\n'.join(path.read_text(encoding='utf-8') for path in runtime_tests)
        for name, cause_id in function_ids.items():
            self.assertIn(f'function sgp.ci:death_cause/expect {{cause:"{name}",id:{cause_id}}}', combined)
