#> sgp.cosmetics:particles/disable
# 
# Disables the particle cloak for the player

function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_weight
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as ", "color":"aqua"}, {"text":"désactivé", "color":"red", "bold":true}, {"text":" ta Trainée de Particules", "color":"aqua"}]
scoreboard players enable @s sgp.veut_desactiver
scoreboard players set @s sgp.veut_desactiver 0