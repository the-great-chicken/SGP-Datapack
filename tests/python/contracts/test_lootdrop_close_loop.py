from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[3]
LOOTDROP = ROOT / "data/sgp.mineurs/function/lootdrop"


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n")


class LootdropCloseDetectionContracts(unittest.TestCase):
    def test_no_scheduled_chain_re_applies_the_loot_table(self):
        for path in LOOTDROP.rglob("*.mcfunction"):
            self.assertNotIn("bs.schedule", read(path), path)
        for path in (LOOTDROP / "close_detection").rglob("*.mcfunction"):
            commands = [line for line in read(path).splitlines() if line and not line.startswith("#")]
            self.assertFalse(any("schedule" in line for line in commands), path)
        for name in ("schedule", "loop", "reapply"):
            self.assertFalse((LOOTDROP / f"close_detection/{name}.mcfunction").exists(), name)

    def test_the_tick_loop_is_the_only_per_tick_re_apply(self):
        tick = read(ROOT / "data/minecraft/function/execute_repeating_functions.mcfunction")
        self.assertIn(
            "function sgp.misc:loop_as_entity/init {list_location:\"sgp:data markers_lists.lootdrop\", "
            "command:\"if block ~ ~ ~ trapped_chest run data modify block ~ ~ ~ LootTable set value 'sgp.misc:empty'\"}",
            tick,
        )
        on_open = read(LOOTDROP / "close_detection/on_open.mcfunction")
        self.assertIn('data modify block ~ ~ ~ LootTable set value "sgp.misc:empty"', on_open)


if __name__ == "__main__":
    unittest.main()
