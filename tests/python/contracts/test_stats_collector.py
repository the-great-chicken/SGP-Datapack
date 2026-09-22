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

        context = (ROOT / 'data/sgp.kits/function/stats_collector/ability/ray_caster_context.mcfunction').read_text(encoding='utf-8')
        tick = (ROOT / 'data/sgp.kits/function/abilities/rays/tick_linked_children.mcfunction').read_text(encoding='utf-8')
        damaged = (ROOT / 'data/sgp.kits/function/abilities/rays/get_damaged.mcfunction').read_text(encoding='utf-8')
        death = (ROOT / 'data/sgp.kits/function/stats_collector/death_cause/ray.mcfunction').read_text(encoding='utf-8')

        # The attacker is resolved once per caster tick, after the no-target early return.
        self.assertIn('run function sgp.kits:stats_collector/can_collect', context)
        self.assertIn('if score @s sgp.ability_kind matches 6', context)
        self.assertIn('if score @s sgp.ability_cast matches 1..', context)
        self.assertIn('#ray_ability_cast sgp.dummy = @s sgp.ability_cast', context)
        self.assertIn('stats.current_damage_info.id_source int 1', context)
        self.assertIn('function sgp.kits:stats_collector/ability/ray_caster_context', tick)
        self.assertLess(tick.index('tick_linked_children_block_only'), tick.index('ray_caster_context'))
        self.assertLess(tick.index('ray_caster_context'), tick.index('update_ray_dispatch'))

        self.assertIn('function sgp.kits:stats_collector/save_damage_received', collector)
        self.assertIn('function sgp.kits:stats_collector/ability/mark_ray_affected with storage sgp:macro stats.current_damage_info', collector)
        self.assertNotIn('on attacker', collector)
        self.assertNotIn('sgp.ability_damage_target', collector)
        self.assertNotIn('function sgp.kits:stats_collector/ability/route_damage', collector)

        # Per-caster victim tags replace the single victim-side cast id that over-counted affected_players.
        self.assertIn('$execute if entity @s[tag=sgp.ability_affected.$(id_source)] run return 0', marker)
        self.assertIn('$tag @s add sgp.ability_affected.$(id_source)', marker)
        self.assertNotIn('sgp.last_ability_cast', marker)
        self.assertIn('execute on attacker run function sgp.kits:stats_collector/ability/mark_success', marker)
        self.assertIn('execute on attacker run function sgp.kits:stats_collector/ability/increment', marker)

        # The ray death-cause callback runs straight after a successful /damage, without an advancement.
        self.assertIn('execute store success score #ray_hit sgp.dummy run damage @s 0.25 sgp.kits:ray', damaged)
        self.assertIn('execute if score #ray_hit sgp.dummy matches 1 run function sgp.kits:stats_collector/death_cause/ray', damaged)
        self.assertNotIn('advancement revoke', death)
        self.assertIn('if score #ray_stats sgp.dummy matches 1', death)
        self.assertFalse((ROOT / 'data/sgp.kits/advancement/death_cause/ray.json').exists())

    def test_generic_affected_players_dedup_uses_per_caster_tags(self):
        marker = (ROOT / 'data/sgp.kits/function/stats_collector/ability/mark_affected.mcfunction').read_text(encoding='utf-8')
        tagger = (ROOT / 'data/sgp.kits/function/stats_collector/ability/tag_affected.mcfunction').read_text(encoding='utf-8')
        start = (ROOT / 'data/sgp.kits/function/stats_collector/ability/start.mcfunction').read_text(encoding='utf-8')
        clear = (ROOT / 'data/sgp.kits/function/stats_collector/ability/clear_affected.mcfunction').read_text(encoding='utf-8')

        self.assertNotIn('sgp.last_ability_cast', marker)
        self.assertIn('run function sgp.kits:stats_collector/ability/tag_affected with storage sgp:macro stats.affected', marker)
        self.assertIn('execute unless score #affected_new sgp.dummy matches 1 run return 0', marker)
        self.assertIn('$execute if entity @a[tag=sgp.ability_damage_target,tag=sgp.ability_affected.$(id),limit=1] run return 0', tagger)
        self.assertIn('$tag @a[tag=sgp.ability_damage_target,limit=1] add sgp.ability_affected.$(id)', tagger)
        self.assertIn('function sgp.kits:stats_collector/ability/clear_affected with storage sgp:macro stats.affected', start)
        self.assertIn('$tag @a remove sgp.ability_affected.$(id)', clear)
