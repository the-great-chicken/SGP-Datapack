tag @s add tag1
function sgp.kits:give {kit:archer}
team leave @s
team join sgp.Chasseurs_pigeon @s
tp @s @e[type=marker,tag=sgp.marker,name="spawns",limit=1]
execute at @e[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur",limit=1] as @a[distance=..2] unless entity @s[tag=sgp.tag1] run tp @s @e[type=marker,tag=sgp.marker,name="sgp.devenir_pigeon",limit=1]
scoreboard players enable @a[scores={sgp.devenir_chasseur=0}] sgp.devenir_pigeon
function sgp.spawns:enable_triggers
move @s #Chasseurs
scoreboard players set @s sgp.devenir_chasseur 0
execute as @a run trigger sgp.devenir_chasseur set 0