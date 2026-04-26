#> sgp.misc:player_mannequins/update_pos

# Grab the player's exact position and rotation
# We scale by 1000 (milliblocks/millidegrees) to prevent the division by 16 from wiping out fractional precision!
function #bs.position:get_pos {scale:1000}
function #bs.position:get_rot {scale:1000}

# Subtract the original map's origin to get the player's relative offset inside the maze
scoreboard players operation @s bs.pos.x -= #map_x sgp.dummy
scoreboard players operation @s bs.pos.y -= #map_y sgp.dummy
scoreboard players operation @s bs.pos.z -= #map_z sgp.dummy

# Divide by 16 to match the miniature model's scale
scoreboard players operation @s bs.pos.x /= 16 sgp.dummy
scoreboard players operation @s bs.pos.y /= 16 sgp.dummy
scoreboard players operation @s bs.pos.z /= 16 sgp.dummy

# Add the miniature map's origin to translate the offset back into absolute world coordinates
scoreboard players operation @s bs.pos.x += #model_x sgp.dummy
scoreboard players operation @s bs.pos.y += #model_y sgp.dummy
scoreboard players operation @s bs.pos.z += #model_z sgp.dummy

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

function #bs.link:as_children {run:"execute if entity @s[tag=sgp.small_mannequin,type=mannequin] run function sgp.misc:player_mannequins/apply_mannequin_pos"}