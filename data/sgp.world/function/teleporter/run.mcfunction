#> sgp.world:teleporter/run
# 
# Manages a teleporter from a place to another: ambient particles,
# countdown, sound,...

particle witch ~ ~ ~ 0.4 0 0.4 0 10 normal
execute unless score @s bs.id matches 1.. run function #bs.id:give_suid
scoreboard players operation #teleport_source sgp.dummy = @s bs.id

# Only this teleporter can cancel or advance its waiting players.
execute as @a[tag=sgp.to_teleport] if score @s sgp.teleport_source = #teleport_source sgp.dummy unless entity @s[distance=..1] run function sgp.world:teleporter/out_of_range
execute as @a[distance=..1,tag=!sgp.to_teleport] run function sgp.world:teleporter/may_teleport

execute as @a[tag=sgp.to_teleport,distance=..1] if score @s sgp.teleport_source = #teleport_source sgp.dummy run scoreboard players add @s sgp.teleporteur 1

function sgp.world:teleporter/teleported with entity @s data
