particle witch 2485.5 210.5 2169.5 0.4 0 0.4 0 10 normal
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=..1,tag=!a_teleporter] at @s run playsound minecraft:block.portal.trigger ambient @s 2485.5 211.5 2169.5 2 1.3
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=..1,tag=!a_teleporter] run tellraw @s [{"text":"Ⓞ ","color":"#700070"},{"text":"Téléportation dans 3 secondes... Ne bougez pas...","color":"dark_purple","bold":true}]
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=..1,tag=!a_teleporter] run tag @s add a_teleporter
scoreboard players add @a[tag=a_teleporter] sgp.teleporteur 1
execute as @a[tag=a_teleporter,scores={sgp.teleporteur=60}] run tp @s 2500.5 224.5 2147.5 0 0
execute as @a[tag=a_teleporter,scores={sgp.teleporteur=60}] at @s run particle minecraft:reverse_portal ~ ~1 ~ 0 0 0 1 200 normal
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=1..,tag=a_teleporter] run stopsound @s ambient block.portal.trigger
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=1..,tag=a_teleporter] run scoreboard players set @s sgp.teleporteur 0
execute as @a[x=2485.5,y=210.5,z=2169.5,distance=1..,tag=a_teleporter] run tag @s remove a_teleporter