#> sgp.bench:scenarios/systems/locations/slot_empty
# j = index - occupied - 1 on an 8x8 lattice, 8 blocks apart, at y 96: inside the
# forceloaded arena, never occupied by an actor, so the box scans find nobody.

scoreboard players operation #locations_slot sgp.bench -= #locations_occupied sgp.bench
scoreboard players operation #locations_col sgp.bench = #locations_slot sgp.bench
scoreboard players operation #locations_col sgp.bench %= #locations_cols sgp.bench
scoreboard players operation #locations_col sgp.bench *= #locations_step sgp.bench
scoreboard players remove #locations_col sgp.bench 32
scoreboard players operation #locations_row sgp.bench = #locations_slot sgp.bench
scoreboard players operation #locations_row sgp.bench /= #locations_cols sgp.bench
scoreboard players operation #locations_row sgp.bench %= #locations_cols sgp.bench
scoreboard players operation #locations_row sgp.bench *= #locations_step sgp.bench
scoreboard players remove #locations_row sgp.bench 32

data modify storage sgp.bench:locations marker.y set value 96
data modify storage sgp.bench:locations marker.dx set value 6
data modify storage sgp.bench:locations marker.dy set value 3
data modify storage sgp.bench:locations marker.dz set value 6
execute store result storage sgp.bench:locations marker.x int 1 run scoreboard players get #locations_col sgp.bench
execute store result storage sgp.bench:locations marker.z int 1 run scoreboard players get #locations_row sgp.bench
