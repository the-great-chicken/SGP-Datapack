#> sgp.ci:diorama_rejoin/fixture
# Register the fixture markers for the complete production Diorama tick.
function sgp.ci:diorama_lifecycle/fixture
fill 32 80 32 39 80 39 stone
fill 4 80 4 12 80 12 stone
data modify storage sgp:data markers_lists.playable_map set value []
data modify storage sgp:data markers_lists.playable_map_model set value []
execute as @n[tag=sgp.ci.lifecycle_map,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.playable_map"}
execute as @n[tag=sgp.ci.lifecycle_model,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.playable_map_model"}
execute as @n[tag=sgp.ci.lifecycle_model,type=marker] run function sgp.diorama:init/markers_pos with entity @s data
scoreboard players set #giant_offset sgp.dummy 8
scoreboard players set #mannequin_update_time sgp.dummy 0
scoreboard players set @s sgp.leave_game 0
scoreboard players reset @s sgp.diorama_leave_seen
