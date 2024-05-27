#> sgp.cosmetics:particles/disable
# 
# Disables the particle cloak for the player

execute as @s run function sgp.cosmetics:particles/disable_type
execute as @s run function sgp.cosmetics:particles/disable_weight
tellraw @s [{"text":"Tu as ", "color":"white"},{"text":"désactivé", "color":"red", "bold":true}," ta Trainée de Particules"]
scoreboard players enable @s sgp.veut_desactiver
scoreboard players set @s sgp.veut_desactiver 0