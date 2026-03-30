#> sgp.cosmetics:particles/disable
# 
# Disables the particle cloak for the player

function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_weight
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.cosmetics:particle_trail", "fallback":"Tu as %s ta Trainée de Particules", "color":"aqua", "with":[{"translate":"sgp.cosmetics:state_deactivated", "fallback":"désactivé", "color":"red", "bold":true}]}]
scoreboard players enable @s sgp.veut_desactiver
scoreboard players set @s sgp.veut_desactiver 0