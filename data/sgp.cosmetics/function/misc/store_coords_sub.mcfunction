#> sgp.cosmetics:misc/store_coords_sub
# 
# Sub-function to avoid checking the player NBT 3 times

data modify storage sgp:player_pos Pos set from entity @s Pos
execute store result score @s sgp.posx run data get storage sgp:player_pos Pos[0] 100
execute store result score @s sgp.posy run data get storage sgp:player_pos Pos[1] 100
execute store result score @s sgp.posz run data get storage sgp:player_pos Pos[2] 100