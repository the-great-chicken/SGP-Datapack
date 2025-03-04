#> sgp.kits:clear
# 
# Clear the player's kit

clear @s
effect clear @s
attribute @s minecraft:generic.step_height modifier remove kit
function sgp.mineurs:bounty/reward/reset
god @s off