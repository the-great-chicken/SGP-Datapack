#> sgp.misc:player_mannequins/init_markers_pos

# --- Fetch the miniature map's origin ---
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] at @s run function #bs.position:get_pos {scale:1000}
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_x sgp.dummy = @s bs.pos.x
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_y sgp.dummy = @s bs.pos.y
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_z sgp.dummy = @s bs.pos.z

# Empty the list of markers
data remove storage sgp:data markers_lists.playable_map_model

# Get UUID to be able to run as this marker every tick without having to resolve @e every time.
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.playable_map_model"}

# --- Fetch the original map's origin ---
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] at @s run function #bs.position:get_pos {scale:1000}
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_x sgp.dummy = @s bs.pos.x
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_y sgp.dummy = @s bs.pos.y
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_z sgp.dummy = @s bs.pos.z


data remove storage sgp:data markers_lists.playable_map
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.playable_map"}

# --- Fetch Map Dimensions from the marker data ---
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] store result score #map_dx sgp.dummy run data get entity @s data.dx
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] store result score #map_dz sgp.dummy run data get entity @s data.dz

# Calculate Map Half-Widths in milliblocks (dx * 1000 / 2 = dx * 500)
scoreboard players operation #map_hw_x sgp.dummy = #map_dx sgp.dummy
scoreboard players operation #map_hw_x sgp.dummy *= 500 sgp.dummy
scoreboard players operation #map_hw_z sgp.dummy = #map_dz sgp.dummy
scoreboard players operation #map_hw_z sgp.dummy *= 500 sgp.dummy

# Calculate Map Center (Map Origin + Half-Width)
scoreboard players operation #map_center_x sgp.dummy = #map_x sgp.dummy
scoreboard players operation #map_center_x sgp.dummy += #map_hw_x sgp.dummy
scoreboard players operation #map_center_z sgp.dummy = #map_z sgp.dummy
scoreboard players operation #map_center_z sgp.dummy += #map_hw_z sgp.dummy

# Define the maximum pushback (in blocks). Change this number to adjust how far away the giant stands!
scoreboard players set #giant_offset sgp.dummy 8