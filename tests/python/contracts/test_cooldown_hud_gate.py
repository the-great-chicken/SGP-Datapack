from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[3]
ACTIONBAR = ROOT / "data/sgp.misc/function/actionbar"


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n")


class CooldownHudGateContracts(unittest.TestCase):
    def test_ability_tick_goes_through_the_gate(self):
        tick = read(ROOT / "data/sgp.kits/function/abilities/tick.mcfunction")
        self.assertIn(
            "execute as @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] \\\n"
            "    run function sgp.misc:actionbar/ability_cooldown_gate\n",
            tick,
        )
        self.assertNotIn("run function sgp.misc:actionbar/ability_cooldown\n", tick)

    def test_gate_only_recomputes_when_the_frame_can_change(self):
        gate = [line for line in read(ACTIONBAR / "ability_cooldown_gate.mcfunction").splitlines() if line and not line.startswith("#")]
        self.assertEqual(gate, [
            "execute unless score @s sgp.ab.ability_cooldown matches 1 run return run function sgp.misc:actionbar/ability_cooldown",
            "execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run return run function sgp.misc:actionbar/ability_cooldown",
            "execute unless score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_next run return run function sgp.misc:actionbar/ability_cooldown",
        ])

    def test_recompute_publishes_the_next_change_threshold(self):
        full = read(ACTIONBAR / "ability_cooldown.mcfunction")
        self.assertIn("scoreboard players operation @s sgp.ab.ability_cooldown_next = #sgp.ab.max sgp.dummy", full)
        self.assertIn("scoreboard players operation @s sgp.ab.ability_cooldown_next -= #sgp.ab.next sgp.dummy", full)
        self.assertIn("%= #sgp.ab.bar_length sgp.dummy", full)
        self.assertLess(full.index("cooldown_frame/calculate"), full.index("sgp.ab.ability_cooldown_next ="))
        for name in ("ability_cooldown_ready", "ability_cooldown_clear"):
            self.assertIn("scoreboard players reset @s sgp.ab.ability_cooldown_next", read(ACTIONBAR / f"{name}.mcfunction"), name)

    def test_objective_lifecycle(self):
        self.assertIn("scoreboard objectives add sgp.ab.ability_cooldown_next dummy", read(ROOT / "data/sgp.misc/function/initialization.mcfunction"))
        self.assertIn("scoreboard objectives remove sgp.ab.ability_cooldown_next", read(ROOT / "data/sgp.misc/function/uninstall.mcfunction"))


if __name__ == "__main__":
    unittest.main()
