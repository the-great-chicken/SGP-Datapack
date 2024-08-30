tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Lancement de la Chasse aux Pigeons...", "color":"gray", "bold":true}]

function sgp.majeurs:common/start

execute as @e[type=marker,tag=sgp.marker,name="devenir_chasseur",limit=1] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"green"}]','[{"text":"CHASSEUR","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_chasseur"}}]','[""]']}}
execute as @e[type=marker,tag=sgp.marker,name="devenir_pigeon",limit=1] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"dark_gray"}]','[{"text":"PIGEON","bold":true,"color":"dark_gray","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_pigeon"}}]','[""]']}}
tp @a[tag=sgp.in_game] @e[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur",limit=1]
scoreboard players set #pigeons_joueurs sgp.dummy 0
execute as @a[tag=sgp.in_game] run scoreboard players add #pigeons_joueurs sgp.dummy 1
scoreboard players set #pigeons_ticks sgp.timer 0
scoreboard players set #pigeons_secondes sgp.timer 0
scoreboard players set #pigeons_minutes sgp.timer 0
scoreboard players set #chasseurs_tues sgp.dummy 0

scoreboard players enable @a[tag=sgp.in_game] sgp.devenir_chasseur
execute as @a[tag=sgp.in_game] run function sgp.kits:misc/sort_salle
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
title @a[tag=sgp.in_game] title [{"text":"Chasse aux Pigeons","color":"gray","bold":true}]
tag @a[tag=sgp.in_game] remove tag1

move @a[tag=sgp.in_game] #Pigeons
