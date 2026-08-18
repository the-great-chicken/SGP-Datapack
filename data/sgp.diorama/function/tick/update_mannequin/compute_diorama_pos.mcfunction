#> sgp.diorama:tick/update_mannequin/compute_diorama_pos
# `{id:int}`

# Subtract the original map's origin to get the player's relative offset
$scoreboard players operation @s bs.pos.x -= #map_$(id)_x sgp.dummy
$scoreboard players operation @s bs.pos.y -= #map_$(id)_y sgp.dummy
$scoreboard players operation @s bs.pos.z -= #map_$(id)_z sgp.dummy

# Divide by 16 to match the miniature model's scale
scoreboard players operation @s bs.pos.x /= 16 sgp.dummy
scoreboard players operation @s bs.pos.y /= 16 sgp.dummy
scoreboard players operation @s bs.pos.z /= 16 sgp.dummy

# Add the miniature map's origin to translate the offset back into absolute world coordinates
$scoreboard players operation @s bs.pos.x += #model_$(id)_x sgp.dummy
$scoreboard players operation @s bs.pos.y += #model_$(id)_y sgp.dummy
$scoreboard players operation @s bs.pos.z += #model_$(id)_z sgp.dummy