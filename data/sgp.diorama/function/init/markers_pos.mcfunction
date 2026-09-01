#> sgp.diorama:init/markers_pos
# `{id: int}`

# warn-off-file execute-group target-selector-no-dimension

# --- Fetch the miniature map's origin ---
execute at @s run function #bs.position:get_pos {scale:1000}
$scoreboard players operation #model_$(id)_x sgp.dummy = @s bs.pos.x
$scoreboard players operation #model_$(id)_y sgp.dummy = @s bs.pos.y
$scoreboard players operation #model_$(id)_z sgp.dummy = @s bs.pos.z

scoreboard players operation $link.to bs.in = @s bs.id

# --- Fetch the original map's origin ---
execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] at @s run function #bs.position:get_pos {scale:1000}
$execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_$(id)_x sgp.dummy = @s bs.pos.x
$execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_$(id)_y sgp.dummy = @s bs.pos.y
$execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] run scoreboard players operation #map_$(id)_z sgp.dummy = @s bs.pos.z

# --- Fetch Map Dimensions from the marker data ---
execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] store result score $map_dx sgp.dummy run data get entity @s data.dx
execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] store result score $map_dy sgp.dummy run data get entity @s data.dy
execute as @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] store result score $map_dz sgp.dummy run data get entity @s data.dz

# Calculate Map Half-Widths in milliblocks (dx * 1000 / 2 = dx * 500)
$scoreboard players operation #map_$(id)_hw_x sgp.dummy = $map_dx sgp.dummy
$scoreboard players operation #map_$(id)_hw_x sgp.dummy *= 500 sgp.dummy
$scoreboard players operation #map_$(id)_hw_z sgp.dummy = $map_dz sgp.dummy
$scoreboard players operation #map_$(id)_hw_z sgp.dummy *= 500 sgp.dummy

# Calculate Map Center (Map Origin + Half-Width)
$scoreboard players operation #map_$(id)_center_x sgp.dummy = #map_$(id)_x sgp.dummy
$scoreboard players operation #map_$(id)_center_x sgp.dummy += #map_$(id)_hw_x sgp.dummy
$scoreboard players operation #map_$(id)_center_z sgp.dummy = #map_$(id)_z sgp.dummy
$scoreboard players operation #map_$(id)_center_z sgp.dummy += #map_$(id)_hw_z sgp.dummy

# --- Calculate diorama's Dimensions ---
# We remove 1000 because when we'll be using it as a bounding box, minecraft inherently adds 1
# We multiply by 1000 not to lose precision, as scoreboards are integers
$scoreboard players operation #model_$(id)_dx sgp.dummy = $map_dx sgp.dummy
$scoreboard players operation #model_$(id)_dx sgp.dummy *= 1000 sgp.dummy
$scoreboard players operation #model_$(id)_dx sgp.dummy /= 16 sgp.dummy
$scoreboard players operation #model_$(id)_dx sgp.dummy -= 1000 sgp.dummy

$scoreboard players operation #model_$(id)_dy sgp.dummy = $map_dy sgp.dummy
$scoreboard players operation #model_$(id)_dy sgp.dummy *= 1000 sgp.dummy
$scoreboard players operation #model_$(id)_dy sgp.dummy /= 16 sgp.dummy
$scoreboard players operation #model_$(id)_dy sgp.dummy -= 1000 sgp.dummy

$scoreboard players operation #model_$(id)_dz sgp.dummy = $map_dz sgp.dummy
$scoreboard players operation #model_$(id)_dz sgp.dummy *= 1000 sgp.dummy
$scoreboard players operation #model_$(id)_dz sgp.dummy /= 16 sgp.dummy
$scoreboard players operation #model_$(id)_dz sgp.dummy -= 1000 sgp.dummy

$execute store result entity @s data.mdx float 0.001 run scoreboard players get #model_$(id)_dx sgp.dummy
$execute store result entity @s data.mdy float 0.001 run scoreboard players get #model_$(id)_dy sgp.dummy
$execute store result entity @s data.mdz float 0.001 run scoreboard players get #model_$(id)_dz sgp.dummy

$scoreboard players operation #model_$(id)_dx sgp.dummy += 9000 sgp.dummy
$scoreboard players operation #model_$(id)_dy sgp.dummy += 9000 sgp.dummy
$scoreboard players operation #model_$(id)_dz sgp.dummy += 9000 sgp.dummy

$execute store result entity @s data.mdx_end float 0.001 run scoreboard players get #model_$(id)_dx sgp.dummy
$execute store result entity @s data.mdy_end float 0.001 run scoreboard players get #model_$(id)_dy sgp.dummy
$execute store result entity @s data.mdz_end float 0.001 run scoreboard players get #model_$(id)_dz sgp.dummy