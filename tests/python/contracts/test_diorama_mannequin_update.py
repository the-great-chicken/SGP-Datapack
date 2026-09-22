from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[3]
UPDATE = ROOT / "data/sgp.diorama/function/tick/update_mannequin"


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n")


def commands(text: str) -> list[str]:
    return [line for line in text.splitlines() if line and not line.startswith("#")]


class DioramaMannequinUpdateContracts(unittest.TestCase):
    def test_owner_position_is_read_through_one_shuttle_trip(self):
        self.assertEqual(commands(read(UPDATE / "read_pos_and_rot.mcfunction")), [
            "tp B5-0-0-0-1 ~ ~ ~ ~ ~",
            "execute store result score @s bs.pos.x run data get entity B5-0-0-0-1 Pos[0] 1000",
            "execute store result score @s bs.pos.y run data get entity B5-0-0-0-1 Pos[1] 1000",
            "execute store result score @s bs.pos.z run data get entity B5-0-0-0-1 Pos[2] 1000",
            "execute store result score @s bs.rot.h run data get entity B5-0-0-0-1 Rotation[0] 1000",
            "execute store result score @s bs.rot.v run data get entity B5-0-0-0-1 Rotation[1] 1000",
            "execute in minecraft:overworld run tp B5-0-0-0-1 -30000000 0 1600 0 0",
        ])
        for name in ("update_small_pos", "update_giant_pos"):
            text = read(UPDATE / f"{name}.mcfunction")
            self.assertIn("function sgp.diorama:tick/update_mannequin/read_pos_and_rot", text, name)
            self.assertNotIn("bs.position:get_pos", text, name)
            self.assertNotIn("data get entity @s", text, name)

    def test_mannequin_is_placed_with_one_teleport(self):
        apply = read(UPDATE / "apply_mannequin_pos.mcfunction")
        self.assertNotIn("bs.position:set_pos", apply)
        for axis, objective in (("x", "bs.pos.x"), ("y", "bs.pos.y"), ("z", "bs.pos.z"), ("h", "bs.rot.h"), ("v", "bs.rot.v")):
            self.assertIn(
                f"execute store result storage sgp:diorama tp.{axis} double 0.001 run scoreboard players get @s {objective}",
                apply,
            )
        self.assertIn("function sgp.diorama:tick/update_mannequin/teleport with storage sgp:diorama tp", apply)
        self.assertEqual(commands(read(UPDATE / "teleport.mcfunction")), ["$execute positioned 0.0 0.0 0.0 positioned ~$(x) ~$(y) ~$(z) rotated $(h) $(v) run tp @s ~ ~ ~ ~ ~"])


if __name__ == "__main__":
    unittest.main()
