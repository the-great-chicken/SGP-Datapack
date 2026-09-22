import unittest

from common import ROOT


class ActionbarMixerCadenceContracts(unittest.TestCase):
    def test_mixer_render_is_throttled_by_existing_even_tick_phase(self):
        tick = (ROOT / 'data/dah.actbar_mixer/function/z_private/tick.mcfunction').read_text(encoding='utf-8')
        command = (
            'execute unless score #off dah.actbar.calc matches 1 '
            'if score #even_tick sgp.dummy matches 0 '
            'run function dah.actbar_mixer:z_private/display/prepare'
        )
        self.assertIn(command, tick)

    def test_even_tick_phase_still_alternates_every_server_tick(self):
        repeating = (ROOT / 'data/minecraft/function/execute_repeating_functions.mcfunction').read_text(encoding='utf-8')
        initialization = (ROOT / 'data/sgp.misc/function/initialization.mcfunction').read_text(encoding='utf-8')
        self.assertIn('scoreboard players set #even_tick sgp.dummy 0', initialization)
        self.assertIn('scoreboard players add #even_tick sgp.dummy 1', repeating)
        self.assertIn(
            'execute if score #even_tick sgp.dummy matches 2.. run scoreboard players set #even_tick sgp.dummy 0',
            repeating,
        )
