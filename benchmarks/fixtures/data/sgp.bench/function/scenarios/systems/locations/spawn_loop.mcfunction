#> sgp.bench:scenarios/systems/locations/spawn_loop
# Summon markers 1..#locations_markers, one per recursion step.

execute if score #locations_index sgp.bench >= #locations_markers sgp.bench run return 0
scoreboard players add #locations_index sgp.bench 1
scoreboard players operation #locations_slot sgp.bench = #locations_index sgp.bench
scoreboard players remove #locations_slot sgp.bench 1

# Default template: an occupied slab spanning every column of the actor grid.
data modify storage sgp.bench:locations marker set value {index:1,x:-24,y:81,z:-14,dx:49,dy:2,dz:6,width:72}
execute store result storage sgp.bench:locations marker.index int 1 run scoreboard players get #locations_index sgp.bench

execute if score #locations_index sgp.bench <= #locations_occupied sgp.bench run function sgp.bench:scenarios/systems/locations/slot_occupied
execute if score #locations_index sgp.bench > #locations_occupied sgp.bench run function sgp.bench:scenarios/systems/locations/slot_empty

execute if score #locations_index sgp.bench <= #locations_exclusions sgp.bench run function sgp.bench:scenarios/systems/locations/spawn_marker_excluded with storage sgp.bench:locations marker
execute if score #locations_index sgp.bench > #locations_exclusions sgp.bench run function sgp.bench:scenarios/systems/locations/spawn_marker with storage sgp.bench:locations marker

function sgp.bench:scenarios/systems/locations/spawn_loop
