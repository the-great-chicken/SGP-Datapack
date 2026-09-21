from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[3]
LIEU = ROOT / "data/sgp.world/function/lieu"
SHARDS = 8


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n")


def macro_lines(text: str, shard: int) -> list[str]:
    joined = text.replace("\\\n", " ")
    return [re.sub(rf"lieu/main/{shard}\b", "lieu/main", line) for line in joined.splitlines() if line.startswith("$")]


class LocationLoopContracts(unittest.TestCase):
    def test_tick_uses_the_dedicated_sharded_loop(self):
        tick = read(ROOT / "data/minecraft/function/execute_repeating_functions.mcfunction")
        self.assertIn("function sgp.world:lieu/tick\n", tick)
        self.assertNotIn('markers_lists.location", command:"run function sgp.world:lieu/lieu_trouve', tick)
        loop = read(LIEU / "tick.mcfunction")
        self.assertIn("data modify storage sgp:data temp.lieu.list set from storage sgp:data markers_lists.location", loop)
        self.assertIn(
            "execute if data storage sgp:data temp.lieu.list[0] run function sgp.world:lieu/loop/0 with storage sgp:data temp.lieu.list[0]",
            loop,
        )

    def test_registration_snapshots_marker_data(self):
        register = read(LIEU / "register.mcfunction")
        self.assertIn('function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.location"}', register)
        self.assertIn("data modify storage sgp:data markers_lists.location[-1].data set from entity @s data", register)
        init = read(ROOT / "data/sgp.world/function/initialization.mcfunction")
        self.assertIn('execute as @e[tag=sgp.marker,name="lieu",type=marker] run function sgp.world:lieu/register', init)
        bench = read(ROOT / "benchmarks/fixtures/data/sgp.bench/function/scenarios/systems/locations/setup.mcfunction")
        self.assertIn("run function sgp.world:lieu/register", bench)

    def test_shards_are_consistent_copies(self):
        main = read(LIEU / "main.mcfunction")
        main_commands = [line for line in main.splitlines() if line and not line.startswith("#")]
        for k in range(SHARDS):
            loop = read(LIEU / f"loop/{k}.mcfunction")
            self.assertIn(
                f"$execute as $(uuid) at @s run function sgp.world:lieu/scan/{k} with storage sgp:data temp.lieu.list[0].data",
                loop,
            )
            self.assertIn("data remove storage sgp:data temp.lieu.list[0]", loop)
            self.assertIn(
                f"execute if data storage sgp:data temp.lieu.list[0] run function sgp.world:lieu/loop/{(k + 1) % SHARDS} with storage sgp:data temp.lieu.list[0]",
                loop,
            )

            scan = read(LIEU / f"scan/{k}.mcfunction")
            self.assertIn(
                f"execute if data storage sgp:data temp.lieu.list[0].data.exclusion_box run return run function sgp.world:lieu/scan_excluded/{k} with storage sgp:data temp.lieu.list[0].data",
                scan,
            )
            self.assertNotIn("check_exclusion", scan)
            self.assertNotIn("from entity", scan)

            excluded = read(LIEU / f"scan_excluded/{k}.mcfunction")
            self.assertIn("set from storage sgp:data temp.lieu.list[0].data.exclusion_box", excluded)
            self.assertNotIn("from entity", excluded)
            self.assertEqual(excluded.count("$execute as @a["), 3)

            shard_main = read(LIEU / f"main/{k}.mcfunction")
            shard_commands = [line for line in shard_main.splitlines() if line and not line.startswith("#")]
            self.assertEqual(shard_commands, main_commands, k)

    def test_sharded_scans_match_the_direct_scan(self):
        trouve = macro_lines(read(LIEU / "lieu_trouve.mcfunction"), 0)
        self.assertEqual(len(trouve), 3)
        plain_expected = [
            re.sub(r"\s*unless function sgp.world:lieu/check_exclusion_macro\s*", " ", trouve[0]),
            trouve[2],
        ]
        for k in range(SHARDS):
            self.assertEqual(macro_lines(read(LIEU / f"scan_excluded/{k}.mcfunction"), k), trouve, k)
            plain = macro_lines(read(LIEU / f"scan/{k}.mcfunction"), k)
            self.assertEqual([re.sub(r"\s+", " ", line) for line in plain], [re.sub(r"\s+", " ", line) for line in plain_expected], k)


if __name__ == "__main__":
    unittest.main()
