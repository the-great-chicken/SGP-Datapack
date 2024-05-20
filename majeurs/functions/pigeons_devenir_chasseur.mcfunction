tag @s add tag1
execute as @s run function kits:archer
team leave @s
team join Chasseurs_pigeon @s
tp @s 2423 251.5 2154 0 0
execute as @p unless entity @s[tag=tag1] run tp @a[x=2408,y=251,z=2139,dx=3,dy=3,dz=3] 2413 251.5 2140 180 0
scoreboard players enable @a[scores={devenir_chasseur=0}] devenir_pigeon
execute as @s run function spawns:enable_triggers
move @s #Chasseurs
scoreboard players set @s devenir_chasseur 0
execute as @a run trigger devenir_chasseur set 0