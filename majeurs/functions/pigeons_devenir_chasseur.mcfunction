tag @s add tag1
execute as @s run function kits:archer
team leave @s
team join Chasseurs_pigeon @s
tp @s @e[type=marker,name="spawns",limit=1]
execute at @e[type=marker,name="devenir_chasseur",limit=1] as @a[distance=..2] unless entity @s[tag=tag1] run tp @s @e[type=marker,name="devenir_pigeon",limit=1]
scoreboard players enable @a[scores={devenir_chasseur=0}] devenir_pigeon
execute as @s run function spawns:enable_triggers
move @s #Chasseurs
scoreboard players set @s devenir_chasseur 0
execute as @a run trigger devenir_chasseur set 0