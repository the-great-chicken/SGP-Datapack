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

        self.assertIn("function bs.raycast:check/block/any with storage bs:data raycast", next_fn)
        self.assertIn("function bs.raycast:react/block", react)
        self.assertIn('blocks:"function #bs.hitbox:callback/get_block_shape"', run)
        self.assertIn('ignored_blocks:"#bs.hitbox:can_pass_through"', run)
        self.assertIn("scoreboard players set #raycast.pb bs.data 1", run)
        self.assertIn("scoreboard players set #raycast.pe bs.data 51", run)

        entity_next = read("raycast_fast/recurse/entities/next.mcfunction")
        self.assertNotIn("check/block", entity_next)

    def test_fast_raycast_preserves_player_selector_and_stale_id_workaround(self):
        next_fn = read("raycast_fast/recurse/next.mcfunction")
        update = read("update_ray_fast.mcfunction")
        react = read("raycast_fast/react/any.mcfunction")

        self.assertIn(
            "type=!#bs.hitbox:intangible,tag=sgp.ray_target,level=0..,tag=!bs.raycast.checked,dx=0,sort=nearest",
            next_fn,
        )
        self.assertIn("scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id", update)
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


if __name__ == "__main__":
    unittest.main()
