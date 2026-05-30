#> sgp.misc:diorama/init_markers

# warn-off-file target-selector-no-dimension

execute as @e[tag=sgp.marker,name=playable_map_model,type=marker] at @s \
    run function sgp.misc:diorama/link_markers_map_to_model

execute as @e[tag=sgp.marker,name=playable_map_model,type=marker] \
    run function sgp.misc:diorama/init_markers_pos with entity @s data


# Empty the list of markers
# Get UUID to be able to run as this marker every tick without having to resolve @e every time.
data remove storage sgp:data markers_lists.playable_map_model
execute as @e[tag=sgp.marker,name=playable_map_model,type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.playable_map_model"}

data remove storage sgp:data markers_lists.playable_map
execute as @e[tag=sgp.marker,name=playable_map,type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.playable_map"}


# Define the maximum pushback (in blocks). Change this number to adjust how far away the giant stands!
scoreboard players set #giant_offset sgp.dummy 8