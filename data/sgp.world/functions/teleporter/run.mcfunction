#> sgp.world:teleporter/run
# 
# Manages a teleporter from a place to another: ambient particles,
# countdown, sound,...

particle witch ~ ~ ~ 0.4 0 0.4 0 10 normal
execute as @a[distance=..1,tag=!sgp.to_teleport] run function sgp.world:teleporter/may_teleport

scoreboard players add @a[tag=sgp.to_teleport] sgp.teleporteur 1

function sgp.world:teleporter/teleported with entity @s data

execute as @a[distance=1..,tag=sgp.to_teleport] run function sgp.world:teleporter/out_of_range