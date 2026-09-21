#> sgp.bench:scenarios/systems/teleporters/slot_pad
# Pad k = index-1 on the floor at x 28, z -12 + 7k (east of the actor grid).

scoreboard players operation #teleporters_slot sgp.bench *= #teleporters_seven sgp.bench
scoreboard players remove #teleporters_slot sgp.bench 12
execute store result storage sgp.bench:teleporters marker.z int 1 run scoreboard players get #teleporters_slot sgp.bench
