#> sgp.bench:scenarios/systems/locations/clear
# Objective removal needs the marker's own `data`, so it must run before the kill.

execute as @e[tag=sgp.bench.locations,type=marker] run function sgp.world:lieu/uninstallation with entity @s data
kill @e[tag=sgp.bench.locations,type=marker]
data remove storage sgp:data markers_lists.location
data remove storage sgp.bench:locations marker
scoreboard players set #locations_markers sgp.bench 0
scoreboard players set #locations_index sgp.bench 0
scoreboard players set #locations_phase sgp.bench 0
scoreboard players set #locations_outside sgp.bench 0
scoreboard players set #nbr_lieu sgp.lieu_count 0
