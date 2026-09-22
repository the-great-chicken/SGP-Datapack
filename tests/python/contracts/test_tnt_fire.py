import json
import unittest

from common import ROOT


class TntFireContracts(unittest.TestCase):
    def test_fire_cooldown_shortcut_is_wired_before_fire_updates(self):
        tick = (ROOT / 'data/sgp.kits/function/abilities/tick.mcfunction').read_text(encoding='utf-8')
        cooldown = 'function sgp.kits:abilities/tnt/tick_fire_cooldowns'
        fire = 'execute as @e[tag=sgp.fire_explosion,type=marker] at @s run function sgp.kits:abilities/tnt/tick_fire'
        self.assertIn(cooldown, tick)
        self.assertIn(fire, tick)
        self.assertLess(tick.index(cooldown), tick.index(fire))

    def test_fire_shortcut_only_arms_after_successful_damage(self):
        for name in ('damage_fire_owned', 'damage_fire_unowned'):
            text = (ROOT / f'data/sgp.kits/function/abilities/tnt/{name}.mcfunction').read_text(encoding='utf-8')
            self.assertIn('execute store success score @s sgp.tnt_fire_cd run damage @s 2 on_fire', text)
            self.assertIn('execute if score @s sgp.tnt_fire_cd matches 1 run function sgp.kits:abilities/tnt/arm_fire_cooldown', text)

        damage_fire = (ROOT / 'data/sgp.kits/function/abilities/tnt/damage_fire.mcfunction').read_text(encoding='utf-8')
        self.assertIn('unless entity @e[type=player,tag=sgp.in_game,tag=!sgp.peaceful,tag=!sgp.tnt_fire_cached,dx=$(diameter),dy=$(diameter),dz=$(diameter),limit=1,sort=arbitrary]', damage_fire)
        self.assertNotIn('run damage @s 2 on_fire', damage_fire)

    def test_on_fire_bypasses_shields(self):
        tag = json.loads((ROOT / 'data/minecraft/tags/damage_type/bypasses_shield.json').read_text(encoding='utf-8'))
        self.assertTrue(tag.get('replace'))
        self.assertIn('minecraft:on_fire', tag['values'])

    def test_custom_cooldown_bypasses_invalidate_fire_cache(self):
        tag = json.loads((ROOT / 'data/minecraft/tags/damage_type/bypasses_cooldown.json').read_text(encoding='utf-8'))
        custom = [value.removeprefix('sgp.kits:') for value in tag['values'] if value.startswith('sgp.kits:')]
        self.assertTrue(custom)
        for name in custom:
            callback = ROOT / f'data/sgp.kits/function/stats_collector/death_cause/{name}.mcfunction'
            self.assertTrue(callback.is_file(), name)
            text = callback.read_text(encoding='utf-8')
            self.assertIn(
                'execute if entity @s[tag=sgp.tnt_fire_cached] run function sgp.kits:abilities/tnt/clear_fire_cooldown',
                text,
                name,
            )

    def test_transient_cache_is_cleared_on_entity_lifecycle_boundaries(self):
        for rel in (
            'data/sgp.kits/function/cleanup_after_death.mcfunction',
            'data/sgp.kits/function/stats_collector/player_identity/capture.mcfunction',
        ):
            text = (ROOT / rel).read_text(encoding='utf-8')
            self.assertIn('function sgp.kits:abilities/tnt/clear_fire_cooldown', text, rel)

        reset = (ROOT / 'data/sgp.kits/function/stats_collector/reset_for_new_edition.mcfunction').read_text(encoding='utf-8')
        self.assertIn('scoreboard players reset * sgp.tnt_fire_cd', reset)
        self.assertIn('tag @a remove sgp.tnt_fire_cached', reset)


if __name__ == '__main__':
    unittest.main()
