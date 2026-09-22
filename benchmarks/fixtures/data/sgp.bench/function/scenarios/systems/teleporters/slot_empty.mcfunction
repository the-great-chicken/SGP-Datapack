#> sgp.bench:scenarios/systems/teleporters/slot_empty
# j = index - standing - 1 on an 8x8 lattice, 8 blocks apart, at y 96: inside the
# forceloaded arena, never within a block of an actor.

scoreboard players operation #teleporters_slot sgp.bench -= #teleporters_standing sgp.bench
scoreboard players operation #teleporters_col sgp.bench = #teleporters_slot sgp.bench
scoreboard players operation #teleporters_col sgp.bench %= #teleporters_cols sgp.bench
scoreboard players operation #teleporters_col sgp.bench *= #teleporters_step sgp.bench
scoreboard players remove #teleporters_col sgp.bench 32
scoreboard players operation #teleporters_row sgp.bench = #teleporters_slot sgp.bench
scoreboard players operation #teleporters_row sgp.bench /= #teleporters_cols sgp.bench
scoreboard players operation #teleporters_row sgp.bench %= #teleporters_cols sgp.bench
scoreboard players operation #teleporters_row sgp.bench *= #teleporters_step sgp.bench
scoreboard players remove #teleporters_row sgp.bench 32

data modify storage sgp.bench:teleporters marker.y set value 96
execute store result storage sgp.bench:teleporters marker.x int 1 run scoreboard players get #teleporters_col sgp.bench
execute store result storage sgp.bench:teleporters marker.z int 1 run scoreboard players get #teleporters_row sgp.bench
