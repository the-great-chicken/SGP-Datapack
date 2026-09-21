#> sgp.misc:actionbar/ability_cooldown_gate
#
# Per tick for every player on cooldown: only recompute the HUD frame when it can change.
# The 0..20 frame changes at most 20 times per cooldown, but the full recompute costs ~21
# commands per player per tick, which with 40 players on cooldown was about 40 % of every
# command the datapack executes. ability_cooldown records the cooldown value at which the
# frame next changes (sgp.ab.ability_cooldown_next); until then only a new cooldown (the
# value went up) or an unset threshold (objective created by a reload mid-cooldown) needs the
# full path. A cooldown that drops (frenzy halves it, death zeroes it) crosses the threshold
# and is redrawn the same tick, exactly like before.
execute unless score @s sgp.ab.ability_cooldown matches 1 run return run function sgp.misc:actionbar/ability_cooldown
execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run return run function sgp.misc:actionbar/ability_cooldown
execute unless score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_next run return run function sgp.misc:actionbar/ability_cooldown
