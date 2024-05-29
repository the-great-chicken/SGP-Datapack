#> sgp.cosmetics:misc/store_coords
# 
# Stores each player's current coordinates and those 1 tick earlier in a scoreboard

# Coords 2 ticks before
execute as @a[tag=in_game] run scoreboard players operation @s sgp.posx1 = @s sgp.posx
execute as @a[tag=in_game] run scoreboard players operation @s sgp.posy1 = @s sgp.posy
execute as @a[tag=in_game] run scoreboard players operation @s sgp.posz1 = @s sgp.posz

# Current coords
execute as @a[tag=in_game] run function sgp.cosmetics:misc/store_coords_sub