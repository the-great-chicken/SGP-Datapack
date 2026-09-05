#> sgp.diorama:tick/main

scoreboard players add #mannequin_update_time sgp.dummy 1

tag @a remove sgp.around_model

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.playable_map", command:"run function sgp.diorama:tick/tick_small with entity @s data"}
function sgp.misc:loop_as_entity/init {list_location:"markers_lists.playable_map_model", command:"run function sgp.diorama:tick/tick_giant with entity @s data"}

# Only update weapons once every few ticks else it's too performance-intensive
execute if score #mannequin_update_time sgp.dummy matches 4.. \
    run scoreboard players set #mannequin_update_time sgp.dummy 0