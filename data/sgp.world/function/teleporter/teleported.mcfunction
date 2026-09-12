#> sgp.world:teleporter/teleported
# `{x, y, z, yaw, pitch}`
# 
# Teleports the player and do additional effects

$execute as @a[tag=sgp.to_teleport,distance=..1,scores={sgp.teleporteur=60}] if score @s sgp.teleport_source = #teleport_source sgp.dummy run function sgp.world:teleporter/finish {x:$(x),y:$(y),z:$(z),yaw:$(yaw),pitch:$(pitch)}
