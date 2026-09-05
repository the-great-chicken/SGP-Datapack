# Validate before replacing the current selection. Unlock ownership stays in Minecraft.
execute unless entity @s[type=player] run return 0
execute unless score @s sgp.kill.firework_unlocked matches 1 run return 0
function sgp.cosmetics:kill_effects/disable
tag @s add sgp.kill.firework
return 1
