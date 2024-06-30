#> sgp.world:teleporter/teleported
# `{x, y, z, yaw, pitch}`
# 
# Teleports the player and do additional effects

$execute as @a[tag=sgp.to_teleport,scores={sgp.teleporteur=60}] run tp @s $(x) $(y) $(z) $(yaw) $(pitch)
execute as @a[tag=sgp.to_teleport,scores={sgp.teleporteur=60}] run execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0 0 0 1 200 normal