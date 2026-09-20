from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[3]
RAYS = ROOT / "data/sgp.kits/function/abilities/rays"


def read(relative: str) -> str:
    return (RAYS / relative).read_text(encoding="utf-8")


class RaysFastRaycastContracts(unittest.TestCase):
    def test_fast_raycast_is_not_limited_to_cardinal_or_clear_beams(self):
        dispatch = read("update_ray_dispatch.mcfunction")
        fast = "execute if score #ray_fast_entity sgp.dummy matches 1 \\\n    run return run function sgp.kits:abilities/rays/update_ray_fast with storage sgp:rays prediction"
        self.assertIn(fast, dispatch)
        self.assertLess(dispatch.index("#ray_fast_entity"), dispatch.index("sgp.ray_cardinal"))

    def test_fast_raycast_keeps_bookshelf_block_collision_path(self):
        next_fn = read("raycast_fast/recurse/next.mcfunction")
        react = read("raycast_fast/react/any.mcfunction")
        run = read("raycast_fast/run.mcfunction")
        init = read("raycast_fast/recurse/init.mcfunction")

        self.assertIn("function bs.raycast:check/block/any with storage bs:data raycast", next_fn)
        self.assertIn("function bs.raycast:react/block", react)
        self.assertIn('blocks:"function #bs.hitbox:callback/get_block_shape"', run)
        self.assertIn('ignored_blocks:"#bs.hitbox:can_pass_through"', run)
        self.assertIn("scoreboard players set #raycast.pb bs.data 1", run)
        self.assertIn("scoreboard players set #raycast.pe bs.data 51", run)
        self.assertIn("execute align xyz run function sgp.kits:abilities/rays/raycast_fast/recurse/next", init)
        self.assertNotIn("#ray_fast_blocks", run + init)

    def test_fast_raycast_preserves_player_selector_and_stale_id_workaround(self):
        next_fn = read("raycast_fast/recurse/next.mcfunction")
        update = read("update_ray_fast.mcfunction")
        cardinal_update = read("update_ray_entities_fast.mcfunction")
        react = read("raycast_fast/react/any.mcfunction")

        self.assertIn(
            "type=!#bs.hitbox:intangible,tag=sgp.ray_target,level=0..,tag=!bs.raycast.checked,dx=0,sort=nearest",
            next_fn,
        )
        self.assertIn("scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id", update)
        # The direct cardinal scan never reads raycast ids, so it must not pay for the reset.
        self.assertNotIn("bs.raycast.id", cardinal_update)
        self.assertIn("tag=bs.raycast.checked,predicate=bs.raycast:internal/id,level=0..", react)

    def test_fast_entity_record_contains_only_ordering_fields(self):
        add = read("raycast_fast/record/add.mcfunction")
        react = read("raycast_fast/react/entity.mcfunction")

        self.assertIn("_.e.id", add)
        self.assertIn("_.e.tmin", add)
        for unused in ("_.e.tmax", "_.e.norm", "_.e.x", "_.e.y", "_.e.z"):
            self.assertNotIn(unused, add)
        self.assertNotIn("$raycast.entry_point", react)
        self.assertNotIn("$raycast.exit_point", react)
        self.assertNotIn("$raycast.hit_face", react)

    def test_fast_path_requires_all_targets_to_use_transient_cache(self):
        cache = read("cache_target_hitboxes.mcfunction")
        self.assertIn("scoreboard players set #ray_fast_entity sgp.dummy 0", cache)
        self.assertIn("unless entity @a[tag=sgp.ray_target,tag=!sgp.ray_hitbox_cached,limit=1]", cache)
        self.assertIn("scoreboard players set #ray_fast_entity sgp.dummy 1", cache)

    def test_clear_cardinal_fast_path_scans_players_once_and_damages_directly(self):
        update = read("update_ray_entities_fast.mcfunction")
        run = read("raycast_fast/cardinal/run.mcfunction")
        hit = read("raycast_fast/cardinal/hit.mcfunction")
        all_cardinal = "\n".join(
            read(f"raycast_fast/cardinal/{name}.mcfunction")
            for name in ("east", "west", "south", "north")
        )

        self.assertIn("function sgp.kits:abilities/rays/raycast_fast/cardinal/run", update)
        self.assertNotIn("recurse", run + all_cardinal)
        self.assertNotIn("bs.raycast.checked", run + all_cardinal)
        self.assertNotIn("raycast.re", run + all_cardinal + hit)
        self.assertNotIn("bs.raycast.id", run + all_cardinal + hit)
        self.assertIn("execute at @s run function sgp.kits:abilities/rays/get_damaged", hit)
        self.assertIn("#raycast.pe bs.data", hit)

    def test_clear_cardinal_scan_is_selector_only(self):
        # No coordinate is ever read: no shuttle, no storage, no scoreboard math, so nothing can overflow or drift.
        names = ("run", "east", "west", "south", "north", "check_east", "check_west", "check_south", "check_north", "hit")
        joined = "\n".join(read(f"raycast_fast/cardinal/{name}.mcfunction") for name in names)
        for forbidden in ("B5-0-0-0-1", "data get", "sgp:rays origin", "bs:data raycast", "bs.ctx",
                          "bs.width", "bs.depth", "sort=nearest", "positioned as @s"):
            self.assertNotIn(forbidden, joined, forbidden)
        for name in ("origin_x", "origin_z", "position_x", "position_z"):
            self.assertFalse((RAYS / f"raycast_fast/cardinal/{name}.mcfunction").exists(), name)
        self.assertNotIn("sgp:rays origin", read("tick_linked_children.mcfunction"))

    def test_clear_cardinal_selector_boxes_are_exact_line_tests(self):
        # Selector deltas include an implicit +1 block, so d=15 spans exactly 16 blocks along the beam.
        # The corridor box proves the hitbox reaches above/beside the beam line on the two transverse axes;
        # the two shifted boxes in check_* prove it also reaches below/before it, i.e. it straddles the line.
        # west/north direction files shift the execution position to the corridor's far corner first, so
        # their check files use the same box offsets as east/south.
        cases = {
            "east": ("execute as @a[tag=sgp.ray_target,dx=15,dy=0,dz=0]",
                     ("positioned ~ ~-1 ~ unless entity @s[dx=15,dy=0,dz=0]",
                      "positioned ~ ~ ~-1 unless entity @s[dx=15,dy=0,dz=0]")),
            "west": ("execute positioned ~-16 ~ ~ as @a[tag=sgp.ray_target,dx=15,dy=0,dz=0]",
                     ("positioned ~ ~-1 ~ unless entity @s[dx=15,dy=0,dz=0]",
                      "positioned ~ ~ ~-1 unless entity @s[dx=15,dy=0,dz=0]")),
            "south": ("execute as @a[tag=sgp.ray_target,dx=0,dy=0,dz=15]",
                      ("positioned ~ ~-1 ~ unless entity @s[dx=0,dy=0,dz=15]",
                       "positioned ~-1 ~ ~ unless entity @s[dx=0,dy=0,dz=15]")),
            "north": ("execute positioned ~ ~ ~-16 as @a[tag=sgp.ray_target,dx=0,dy=0,dz=15]",
                      ("positioned ~ ~-1 ~ unless entity @s[dx=0,dy=0,dz=15]",
                       "positioned ~-1 ~ ~ unless entity @s[dx=0,dy=0,dz=15]")),
        }
        for name, (scan, transverse) in cases.items():
            direction = read(f"raycast_fast/cardinal/{name}.mcfunction")
            check = read(f"raycast_fast/cardinal/check_{name}.mcfunction")
            self.assertIn(f"{scan} run function sgp.kits:abilities/rays/raycast_fast/cardinal/check_{name}", direction)
            self.assertIn("execute if score #raycast.pe bs.data matches ..0 run return 0", check)
            for box in transverse:
                self.assertIn(f"execute {box} run return 0", check)
            self.assertLess(check.index("matches ..0"), check.index(transverse[0]))
            self.assertLess(check.index(transverse[1]), check.index("cardinal/hit"))

    def test_diagonal_clear_band_covers_every_voxel_the_dda_can_visit(self):
        dispatch = read("update_ray_block_dispatch.mcfunction")
        self.assertIn(
            "execute if entity @s[tag=!sgp.ray_cardinal] \\\n    if function sgp.kits:abilities/rays/diagonal_clear \\\n"
            "        run return run function sgp.kits:abilities/rays/update_ray_clear with storage sgp:rays prediction",
            dispatch,
        )
        self.assertLess(dispatch.index("cardinal_clear"), dispatch.index("diagonal_clear"))
        self.assertLess(dispatch.index("diagonal_clear"), dispatch.index("update_ray_block_only"))

        band = {(i, j) for i in range(13) for j in range(13) if abs(i - j) <= 2}
        self.assertEqual(len(band), 59)
        signs = {"north_east": (1, -1), "south_east": (1, 1), "south_west": (-1, 1), "north_west": (-1, -1)}
        root = read("diagonal_clear.mcfunction")
        self.assertTrue(root.rstrip().endswith("return 0"))
        for direction, (sx, sz) in signs.items():
            self.assertIn(
                f"execute if entity @s[tag=sgp.{direction}] run return run function sgp.kits:abilities/rays/diagonal_clear/{direction}",
                root,
            )
            text = read(f"diagonal_clear/{direction}.mcfunction")
            offsets = re.findall(r"if block ~(-?\d+) ~ ~(-?\d+) #bs\.hitbox:can_pass_through", text)
            self.assertEqual(len(offsets), 59, direction)
            self.assertEqual({(int(x) * sx, int(z) * sz) for x, z in offsets}, band, direction)
            self.assertIn("run return 1", text)
            self.assertTrue(text.rstrip().endswith("return 0"), direction)
            # Nearest voxels first so a wall next to the caster exits early.
            sums = [abs(int(x)) + abs(int(z)) for x, z in offsets]
            self.assertEqual(sums, sorted(sums), direction)


if __name__ == "__main__":
    unittest.main()
