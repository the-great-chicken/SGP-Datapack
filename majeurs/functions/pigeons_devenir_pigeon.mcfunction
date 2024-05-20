execute as @s run function kits:pigeon
glow @s 1000000
tag @s add tag1
team join Pigeons @s
tp @s 2423 251.5 2154 0 0
execute as @s run function spawns:enable_triggers
scoreboard players set @s devenir_pigeon 0
targetglow @a[team=Chasseurs_pigeon] @a[team=Pigeons] GRAY