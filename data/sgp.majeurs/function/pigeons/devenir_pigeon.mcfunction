execute as @s run function sgp.kits:collection/pigeon
glow @s 1000000
tag @s add tag1
team join sgp.Pigeons @s
tp @s @n[type=marker,tag=sgp.marker,name="spawns"]
execute as @s run function sgp.spawns:enable_triggers
scoreboard players set @s sgp.devenir_pigeon 0
targetglow @a[team=sgp.Chasseurs_pigeon] @a[team=sgp.Pigeons] GRAY