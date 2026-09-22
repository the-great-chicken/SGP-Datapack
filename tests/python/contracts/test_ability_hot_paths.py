from pathlib import Path
import json
import unittest

ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "data"


def read(relative: str) -> str:
    return (DATA / relative).read_text(encoding="utf-8")


class AbilityHotPathContracts(unittest.TestCase):
    def test_illusions_only_write_pose_nbt_when_it_changes(self):
        apply = read("sgp.kits/function/abilities/illusions/apply_offset.mcfunction")
        self.assertIn("execute if score @s sgp.illusion_pose = #pose sgp.dummy run return 0", apply)
        self.assertLess(apply.index("sgp.illusion_pose"), apply.index("pose set value"))
        self.assertIn("scoreboard objectives add sgp.illusion_pose dummy", read("sgp.kits/function/initialization.mcfunction"))
        self.assertIn("scoreboard objectives remove sgp.illusion_pose", read("sgp.kits/function/uninstall.mcfunction"))

    def test_pecking_probes_short_circuit_without_player_scans(self):
        tick = read("sgp.kits/function/abilities/pecking/tick.mcfunction")
        self.assertIn(
            "execute unless entity @a[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..6,limit=1] "
            "run return run function sgp.kits:abilities/pecking/no_target",
            tick,
        )
        self.assertNotIn("unless entity @a[tag=sgp.is_being_pecked] positioned", tick)
        self.assertEqual(tick.count("store success score #peck_found sgp.dummy"), 12)
        self.assertEqual(tick.count("execute if score #peck_found sgp.dummy matches 0 "), 11)
        self.assertLess(tick.index("pecking/no_target"), tick.index("#peck_found"))
        no_target = read("sgp.kits/function/abilities/pecking/no_target.mcfunction")
        self.assertIn("tag @s remove sgp.source_peck", no_target)
        self.assertIn("function sgp.kits:abilities/pecking/end", no_target)

    def test_player_uuid_reads_go_through_the_cache(self):
        production = [
            path for path in (DATA / "sgp.kits/function/abilities").rglob("*.mcfunction")
        ]
        offenders = [
            path.relative_to(ROOT).as_posix()
            for path in production
            if "set from entity @s UUID" in path.read_text(encoding="utf-8")
        ]
        self.assertEqual(offenders, [], "use sgp.misc:player_uuid/to_macro instead of serializing the player")
        loader = read("sgp.misc/function/player_uuid/load.mcfunction")
        self.assertIn('$execute unless data storage sgp:data misc.uuid_cache."$(id)" run data modify storage sgp:data misc.uuid_cache."$(id)" set from entity @s UUID', loader)
        self.assertIn("data remove storage sgp:data misc.uuid_cache", read("sgp.misc/function/uninstall.mcfunction"))
        for relative in (
            "sgp.kits/function/abilities/fangs/summon_owned.mcfunction",
            "sgp.kits/function/abilities/repulsion/start.mcfunction",
            "sgp.kits/function/abilities/tnt/start.mcfunction",
            "sgp.kits/function/abilities/illusions/start.mcfunction",
        ):
            self.assertIn("function sgp.misc:player_uuid/to_macro", read(relative), relative)
        self.assertIn("$summon evoker_fangs ~ ~ ~ {Owner:$(uuid)}", read("sgp.kits/function/abilities/fangs/summon_owned_macro.mcfunction"))

    def test_hud_overlay_is_cached_per_player_behind_an_exact_signature(self):
        render = read("dah.actbar_mixer/function/z_private/display/render.mcfunction").replace("\r\n", "\n")
        self.assertNotIn("function sgp.misc:actionbar/hud/build\n", render)
        for line in (
            "function sgp.misc:actionbar/hud/build_width",
            "function sgp.misc:actionbar/hud/signature",
            "execute unless data storage dah:actbar data[0].sgp_hud run scoreboard players reset @s sgp.ab.hud_sig_cached",
            "execute if score @s sgp.ab.hud_sig = @s sgp.ab.hud_sig_cached run function sgp.misc:actionbar/hud/restore_cached",
            "execute unless score @s sgp.ab.hud_sig = @s sgp.ab.hud_sig_cached run function sgp.misc:actionbar/hud/rebuild_cached",
        ):
            self.assertIn(line, render)
        self.assertLess(render.index("hud/signature"), render.index("title @s actionbar"))
        signature = read("sgp.misc/function/actionbar/hud/signature.mcfunction")
        for source in ("sgp.ab.normal_width", "sgp.ab.hud_ability_fill", "sgp.kit_id", "sgp.ab.hud_ability"):
            self.assertIn(source, signature)
        build = read("sgp.misc/function/actionbar/hud/build.mcfunction").replace("\r\n", "\n")
        self.assertIn("function sgp.misc:actionbar/hud/build_width\nfunction sgp.misc:actionbar/hud/build_glyphs", build)
        init = read("sgp.misc/function/initialization.mcfunction")
        self.assertIn("scoreboard players reset * sgp.ab.hud_sig_cached", init)
        self.assertIn("scoreboard players set 32 sgp.dummy 32", init)

    def test_assassinate_advancement_is_prefiltered_by_stance_score(self):
        advancement = json.loads(read("sgp.kits/advancement/assassinate.json"))
        conditions = advancement["criteria"]["took_hit"]["conditions"]
        self.assertEqual(conditions["player"], [{
            "condition": "minecraft:entity_scores",
            "entity": "this",
            "scores": {"sgp.assassin_stance": {"min": 1}},
        }])
        self.assertEqual(conditions["damage"], {"source_entity": {}})
        self.assertIn("scoreboard players set @s sgp.assassin_stance 1", read("sgp.kits/function/abilities/assassinate/start.mcfunction"))
        self.assertIn("scoreboard players reset @s sgp.assassin_stance", read("sgp.kits/function/abilities/assassinate/end.mcfunction"))
        self.assertIn("scoreboard objectives add sgp.assassin_stance dummy", read("sgp.kits/function/initialization.mcfunction"))
        self.assertIn("scoreboard objectives remove sgp.assassin_stance", read("sgp.kits/function/uninstall.mcfunction"))
        # The tag remains the source of truth inside the reward function.
        self.assertIn("execute if entity @s[tag=sgp.assassin] run function", read("sgp.kits/function/abilities/assassinate/trigger_check.mcfunction"))


if __name__ == "__main__":
    unittest.main()
