#> sgp.kits:clear
# 
# Clear the player's kit

clear @s
effect clear @s
scoreboard players set @s sgp.kit_id -1
attribute @s minecraft:step_height modifier remove sgp:kit