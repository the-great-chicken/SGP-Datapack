#> sgp.cosmetics:particles/manually_disable
# 
# Disables the particle cloak for the player

function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Tu as ", color:aqua}, {text:"désactivé", color:red, bold:true}, {text:" ta Trainée de Particules", color:aqua}]