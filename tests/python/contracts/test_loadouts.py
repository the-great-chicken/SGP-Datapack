import unittest

from common import ROOT


class LoadoutContracts(unittest.TestCase):
    def test_every_kit_collection_has_a_public_loadout_test(self):
        collection = ROOT / 'data/sgp.kits/function/collection'
        kits = sorted(
            path.name
            for path in collection.iterdir()
            if path.is_dir()
            and (path / 'items.mcfunction').is_file()
            and (path / 'specifics.mcfunction').is_file()
        )
        tests = {
            path.stem: path
            for path in (ROOT / 'data/sgp.kits/test/loadouts').glob('*.mcfunction')
        }
        self.assertEqual(set(tests), set(kits))
        for kit in kits:
            text = tests[kit].read_text(encoding='utf-8')
            self.assertIn('# @dummy', text, tests[kit])
            self.assertIn(f'function sgp.kits:give {{kit:"{kit}"}}', text, tests[kit])
