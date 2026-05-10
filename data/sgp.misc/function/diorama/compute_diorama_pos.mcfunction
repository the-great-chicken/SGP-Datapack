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