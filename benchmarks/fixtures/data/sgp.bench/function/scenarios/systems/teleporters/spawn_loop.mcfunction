#> sgp.bench:scenarios/systems/teleporters/spawn_loop
# Summon markers 1..#teleporters_markers, one per recursion step.

execute if score #teleporters_index sgp.bench >= #teleporters_markers sgp.bench run return 0
scoreboard players add #teleporters_index sgp.bench 1
scoreboard players operation #teleporters_slot sgp.bench = #teleporters_index sgp.bench
scoreboard players remove #teleporters_slot sgp.bench 1

data modify storage sgp.bench:teleporters marker set value {index:1,x:28,y:81,z:-12}
execute store result storage sgp.bench:teleporters marker.index int 1 run scoreboard players get #teleporters_index sgp.bench

execute if score #teleporters_index sgp.bench <= #teleporters_standing sgp.bench run function sgp.bench:scenarios/systems/teleporters/slot_pad
execute if score #teleporters_index sgp.bench > #teleporters_standing sgp.bench run function sgp.bench:scenarios/systems/teleporters/slot_empty
function sgp.bench:scenarios/systems/teleporters/spawn_marker with storage sgp.bench:teleporters marker

function sgp.bench:scenarios/systems/teleporters/spawn_loop
