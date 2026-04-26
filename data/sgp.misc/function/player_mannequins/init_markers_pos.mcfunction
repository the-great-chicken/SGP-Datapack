#> sgp.misc:player_mannequins/init_markers_pos

# --- Fetch the original map's origin ---
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] at @s run function #bs.position:get_pos {scale:1000}
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_x sgp.dummy = @s bs.pos.x
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_y sgp.dummy = @s bs.pos.y
execute as @e[tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_z sgp.dummy = @s bs.pos.z

# --- Fetch the miniature map's origin ---
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] at @s run function #bs.position:get_pos {scale:1000}
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_x sgp.dummy = @s bs.pos.x
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_y sgp.dummy = @s bs.pos.y
execute as @e[tag=sgp.marker,name=playable_map_model,limit=1,type=marker] run scoreboard players operation #model_z sgp.dummy = @s bs.pos.z