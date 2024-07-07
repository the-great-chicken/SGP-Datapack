tellraw @a[tag=sgp.in_game] [{"text":"Lancement de la Chasse aux Pigeons...","color":"gray","bold":true}]
scoreboard players set @a[tag=sgp.in_game] sgp.death_reset_tags 1
execute as @n[type=marker,tag=sgp.marker,name="devenir_chasseur"] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"green"}]','[{"text":"CHASSEUR","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_chasseur"}}]','[""]']}}
execute as @n[type=marker,tag=sgp.marker,name="devenir_pigeon"] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"dark_gray"}]','[{"text":"PIGEON","bold":true,"color":"dark_gray","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_pigeon"}}]','[""]']}}
tp @a[tag=sgp.in_game] @n[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur"]
scoreboard players set #pigeons_joueurs sgp.dummy 0
execute as @a[tag=sgp.in_game] run scoreboard players add #pigeons_joueurs sgp.dummy 1
scoreboard players set #pigeons_ticks sgp.timer 0
scoreboard players set #pigeons_secondes sgp.timer 0
scoreboard players set #pigeons_minutes sgp.timer 0
scoreboard players set #chasseurs_tues sgp.dummy 0
function sgp.mineurs:_stop
scoreboard players enable @a[tag=sgp.in_game] sgp.devenir_chasseur
execute as @a[tag=sgp.in_game] run function sgp.kits:misc/sort_salle
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
title @a[tag=sgp.in_game] title [{"text":"Chasse aux Pigeons","color":"gray","bold":true}]
tag @a[tag=sgp.in_game] remove tag1
statuswarp pvp disabled
move @a[tag=sgp.in_game] #Pigeons
function sgp.lore:npcs/disable