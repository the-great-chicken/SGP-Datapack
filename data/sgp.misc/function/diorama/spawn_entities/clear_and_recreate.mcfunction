#> sgp.misc:diorama/spawn_entities/clear_and_recreate
#
# Remove interaction entities present in the model, and create new updated ones

execute store result storage sgp:macro model.dx int 1 run scoreboard players get #model_dx sgp.dummy
execute store result storage sgp:macro model.dy int 1 run scoreboard players get #model_dy sgp.dummy
execute store result storage sgp:macro model.dz int 1 run scoreboard players get #model_dz sgp.dummy

execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] at @s run function sgp.misc:diorama/spawn_entities/clear_volume with storage sgp:macro model

data modify storage sgp:data temp.spawns_list set from storage sgp:data spawns
function sgp.misc:diorama/spawn_entities/create_loop