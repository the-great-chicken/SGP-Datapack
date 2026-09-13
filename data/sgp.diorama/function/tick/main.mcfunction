#> sgp.diorama:tick/main

execute as @a unless score @s sgp.diorama_leave_seen = @s sgp.leave_game run function sgp.diorama:player_initialization

scoreboard players add #mannequin_update_time sgp.dummy 1

tag @a remove sgp.around_model

function sgp.misc:loop_as_entity/init {list_location:"sgp:data markers_lists.playable_map", command:"run function sgp.diorama:tick/tick_small with entity @s data"}
function sgp.misc:loop_as_entity/init {list_location:"sgp:data markers_lists.playable_map_model", command:"run function sgp.diorama:tick/tick_giant with entity @s data"}

# Only update weapons once every few ticks else it's too performance-intensive
execute if score #mannequin_update_time sgp.dummy matches 4.. \
    run scoreboard players set #mannequin_update_time sgp.dummy 0
