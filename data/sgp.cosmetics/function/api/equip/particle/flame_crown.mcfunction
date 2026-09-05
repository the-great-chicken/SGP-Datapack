# Validate before replacing the current selection. Unlock ownership stays in Minecraft.
execute unless entity @s[type=player] run return 0
execute unless score @s sgp.particle.flame_crown_unlocked matches 1 run return 0
function sgp.cosmetics:particles/disable_type
tag @s add sgp.particle.flame_crown
return 1
