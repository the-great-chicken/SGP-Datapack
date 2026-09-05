# Validate before replacing the current selection. Unlock ownership stays in Minecraft.
execute unless entity @s[type=player] run return 0
execute unless score @s sgp.particle.cloud_unlocked matches 1 run return 0
function sgp.cosmetics:particles/disable_type
tag @s add sgp.particle.cloud
return 1
