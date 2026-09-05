# Validate before replacing the current selection. Unlock ownership stays in Minecraft.
execute unless entity @s[type=player] run return 0
execute unless score @s sgp.intensity.super_heavy_unlocked matches 1 run return 0
function sgp.cosmetics:particles/disable_intensity
tag @s add sgp.intensity.super_heavy
return 1
