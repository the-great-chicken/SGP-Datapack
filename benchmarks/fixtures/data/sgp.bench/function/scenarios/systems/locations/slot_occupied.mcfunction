#> sgp.bench:scenarios/systems/locations/slot_occupied
# Row r = (index-1) % 5 of the 8-wide actor grid: z0 = -14 + 7r, box z spans [z0, z0+7).

scoreboard players operation #locations_slot sgp.bench %= #locations_rows sgp.bench
scoreboard players operation #locations_slot sgp.bench *= #locations_pitch sgp.bench
scoreboard players remove #locations_slot sgp.bench 14
execute store result storage sgp.bench:locations marker.z int 1 run scoreboard players get #locations_slot sgp.bench
