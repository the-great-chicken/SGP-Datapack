#> sgp.bench:scenarios/systems/teleporters/clear

kill @e[tag=sgp.bench.teleporters,type=marker]
data remove storage sgp:data markers_lists.teleporter
data remove storage sgp.bench:teleporters marker
data remove storage sgp.bench:teleporters actor
scoreboard players set #teleporters_markers sgp.bench 0
scoreboard players set #teleporters_index sgp.bench 0
scoreboard players set #teleporters_actor sgp.bench 0
