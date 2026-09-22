#> sgp.bench:scenarios/systems/teleporters/place_standing
# Actor (first + k) onto pad k+1 for k in 0..standing-1.

execute if score #teleporters_actor sgp.bench >= #teleporters_standing sgp.bench run return 0
scoreboard players operation #teleporters_slot sgp.bench = #teleporters_actor sgp.bench
scoreboard players operation #teleporters_slot sgp.bench *= #teleporters_seven sgp.bench
scoreboard players remove #teleporters_slot sgp.bench 12
scoreboard players operation #teleporters_id sgp.bench = #teleporters_first sgp.bench
scoreboard players operation #teleporters_id sgp.bench += #teleporters_actor sgp.bench
execute store result storage sgp.bench:teleporters actor.z int 1 run scoreboard players get #teleporters_slot sgp.bench
execute store result storage sgp.bench:teleporters actor.id int 1 run scoreboard players get #teleporters_id sgp.bench
function sgp.bench:scenarios/systems/teleporters/tp_standing with storage sgp.bench:teleporters actor
scoreboard players add #teleporters_actor sgp.bench 1
function sgp.bench:scenarios/systems/teleporters/place_standing
