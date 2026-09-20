from pathlib import Path
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
        self.assertIn("scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id", cardinal_update)
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
        self.assertEqual(all_cardinal.count("sort=nearest"), 4)
        self.assertNotIn("raycast.re", run + all_cardinal + hit)
        self.assertNotIn("bs.raycast.id", run + all_cardinal + hit)
        self.assertIn("execute at @s run function sgp.kits:abilities/rays/get_damaged", hit)
        self.assertIn("#raycast.pe bs.data", hit)

    def test_clear_cardinal_intersection_calls_direct_hit_only_after_exact_tmin(self):
        for name in ("east", "west", "south", "north"):
            check = read(f"raycast_fast/cardinal/check_{name}.mcfunction")
            self.assertIn("matches 0..16000", check)
            self.assertIn("raycast_fast/cardinal/hit", check)
            self.assertIn("#raycast.pe bs.data matches ..0", check)

    def test_clear_cardinal_selector_boxes_cover_exact_16_block_segment_with_margin(self):
        east = read("raycast_fast/cardinal/east.mcfunction")
        west = read("raycast_fast/cardinal/west.mcfunction")
        south = read("raycast_fast/cardinal/south.mcfunction")
        north = read("raycast_fast/cardinal/north.mcfunction")

        # Selector deltas include an implicit +1 block in 26.1.2. These offsets therefore
        # cover [-0.01, 16.01] or [-16.01, 0.01] along the ray axis.
        self.assertIn("positioned ~-0.01 ~-0.01 ~-0.01", east)
        self.assertIn("dx=15.02,dy=0,dz=0", east)
        self.assertIn("positioned ~-0.99 ~-0.01 ~-0.01", west)
        self.assertIn("dx=-15.02,dy=0,dz=0", west)
        self.assertIn("dx=0,dy=0,dz=15.02", south)
        self.assertIn("positioned ~-0.01 ~-0.01 ~-0.99", north)
        self.assertIn("dx=0,dy=0,dz=-15.02", north)

    def test_clear_cardinal_intersection_uses_one_axis_position_and_exact_tmin(self):
        east = read("raycast_fast/cardinal/check_east.mcfunction")
        west = read("raycast_fast/cardinal/check_west.mcfunction")
        south = read("raycast_fast/cardinal/check_south.mcfunction")
        north = read("raycast_fast/cardinal/check_north.mcfunction")
        pos_x = read("raycast_fast/cardinal/position_x.mcfunction")
        pos_z = read("raycast_fast/cardinal/position_z.mcfunction")

        self.assertIn("data get entity @s Pos[0] 10000000", pos_x)
        self.assertIn("data get entity @s Pos[2] 10000000", pos_z)
        self.assertNotIn("bs:ctx _ set from entity", pos_x + pos_z)
        self.assertIn("#x bs.ctx -= #w bs.ctx", east)
        self.assertIn("#x bs.ctx += #w bs.ctx", west)
        self.assertIn("#x bs.ctx -= #w bs.ctx", south)
        self.assertIn("#x bs.ctx += #w bs.ctx", north)
        self.assertIn("#x bs.ctx *= -1 bs.const", west + north)
        for text in (east, west, south, north):
            self.assertIn("#x bs.ctx /= 10000 bs.const", text)
            self.assertIn("matches 0..16000", text)


if __name__ == "__main__":
    unittest.main()
