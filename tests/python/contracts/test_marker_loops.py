from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[3]
LOOP = ROOT / "data/sgp.misc/function/loop_as_entity"
SHARDS = 8


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n")


def commands(text: str) -> list[str]:
    return [line for line in text.splitlines() if line and not line.startswith("#")]


class MarkerLoopContracts(unittest.TestCase):
    def test_loop_as_entity_rotates_through_shards(self):
        init = read(LOOP / "init.mcfunction")
        self.assertIn("function sgp.misc:loop_as_entity/recursion/0 with storage sgp:data temp.run_args", init)
        self.assertFalse((LOOP / "recursion.mcfunction").exists())
        reference = commands(read(LOOP / "recursion/0.mcfunction"))
        for k in range(SHARDS):
            shard = commands(read(LOOP / f"recursion/{k}.mcfunction"))
            self.assertEqual(shard[0], "$execute as $(uuid) at @s $(command)", k)
            self.assertEqual(
                shard[-1],
                f"function sgp.misc:loop_as_entity/recursion/{(k + 1) % SHARDS} with storage sgp:data temp.run_args",
                k,
            )
            self.assertEqual(shard[:-1], reference[:-1], k)

    def test_no_caller_uses_the_removed_single_file_recursion(self):
        for path in (ROOT / "data").rglob("*.mcfunction"):
            if path.is_relative_to(LOOP):
                continue
            self.assertNotIn("loop_as_entity/recursion", read(path), path)

    def test_teleporter_arrival_macro_is_guarded(self):
        run = read(ROOT / "data/sgp.world/function/teleporter/run.mcfunction")
        self.assertIn(
            "execute if entity @a[tag=sgp.to_teleport,distance=..1,scores={sgp.teleporteur=60}] "
            "run function sgp.world:teleporter/teleported with entity @s data",
            run,
        )
        self.assertNotIn("\nfunction sgp.world:teleporter/teleported", run)
        teleported = read(ROOT / "data/sgp.world/function/teleporter/teleported.mcfunction")
        self.assertIn("scores={sgp.teleporteur=60}", teleported)


if __name__ == "__main__":
    unittest.main()
