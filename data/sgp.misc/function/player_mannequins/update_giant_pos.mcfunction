#> sgp.misc:player_mannequins/update_giant_pos

# Grab the player's exact position and rotation
function #bs.position:get_pos {scale:1000}
function #bs.position:get_rot {scale:1000}

# Subtract the miniature map's origin to get the relative offset
scoreboard players operation @s bs.pos.x -= #model_x sgp.dummy
scoreboard players operation @s bs.pos.y -= #model_y sgp.dummy
scoreboard players operation @s bs.pos.z -= #model_z sgp.dummy

# MULTIPLY by 16 to scale the movement up to the real map's size
scoreboard players operation @s bs.pos.x *= 16 sgp.dummy
scoreboard players operation @s bs.pos.y *= 16 sgp.dummy
scoreboard players operation @s bs.pos.z *= 16 sgp.dummy

# Add the original map's origin to translate back to absolute world coordinates
scoreboard players operation @s bs.pos.x += #map_x sgp.dummy
scoreboard players operation @s bs.pos.y += #map_y sgp.dummy
scoreboard players operation @s bs.pos.z += #map_z sgp.dummy

# Store the final position and rotation into global temporary fake players
scoreboard players operation #temp_x sgp.dummy = @s bs.pos.x
scoreboard players operation #temp_y sgp.dummy = @s bs.pos.y
scoreboard players operation #temp_z sgp.dummy = @s bs.pos.z
scoreboard players operation #temp_h sgp.dummy = @s bs.rot.h
scoreboard players operation #temp_v sgp.dummy = @s bs.rot.v

# Update the player's pose status
scoreboard players set #pose sgp.dummy 0
execute if predicate sgp.misc:is_sneaking run scoreboard players set #pose sgp.dummy 1
execute if predicate sgp.misc:is_swimming run scoreboard players set #pose sgp.dummy 2

function #bs.link:as_children {run:"execute if entity @s[tag=sgp.giant_mannequin,type=mannequin] run function sgp.misc:player_mannequins/apply_mannequin_pos"}