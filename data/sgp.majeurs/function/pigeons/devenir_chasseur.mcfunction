tag @s add tag1
execute as @s run function sgp.kits:collection/archer
team leave @s
team join sgp.Chasseurs_pigeon @s
tp @s @n[type=marker,tag=sgp.marker,name="spawns"]
execute at @n[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur"] as @a[distance=..2] unless entity @s[tag=sgp.tag1] run tp @s @n[type=marker,tag=sgp.marker,name="sgp.devenir_pigeon"]
scoreboard players enable @a[scores={sgp.devenir_chasseur=0}] sgp.devenir_pigeon
execute as @s run function sgp.spawns:enable_triggers
move @s #Chasseurs
scoreboard players set @s sgp.devenir_chasseur 0
execute as @a run trigger sgp.devenir_chasseur set 0