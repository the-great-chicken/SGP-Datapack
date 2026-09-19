import re
import unittest

from common import ROOT


class ActionbarMixerContracts(unittest.TestCase):
    def test_uid_waits_are_preceded_by_fresh_registration(self):
        fresh_function = 'function sgp.ci:actionbar_mixer/fresh_registration'
        wait_pattern = re.compile(r'^await score (\S+) dah\.actbar\.UID matches 1\.\.$', re.MULTILINE)
        waits = []
        for path in sorted((ROOT / 'data').rglob('*.mcfunction')):
            text = path.read_text(encoding='utf-8')
            for match in wait_pattern.finditer(text):
                target = match.group(1)
                expected = fresh_function if target == '@s' else f'execute as {target} run {fresh_function}'
                self.assertIn(expected, text[:match.start()], (path, target))
                waits.append((path, target))
        self.assertTrue(waits, 'expected at least one Mixer UID registration wait')
