#> sgp.cosmetics:particles/disable
# 
# Disables the particle cloak for the player

execute as @s run function sgp.cosmetics:particles/disable_type
execute as @s run function sgp.cosmetics:particles/disable_weight
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as ", "color":"aqua"}, {"text":"désactivé", "color":"red", "bold":true}, {"text":" ta Trainée de Particules", "color":"aqua"}]
scoreboard players enable @s sgp.veut_desactiver
scoreboard players set @s sgp.veut_desactiver 0