tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement de la Chasse aux sgp.Pigeons...","color":"gray","bold":true}]
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] sgp.death_reset_tags 1
tp @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] @e[tag=sgp.marker,name="sgp.devenir_chasseur",limit=1]
scoreboard players set #pigeons_joueurs sgp.dummy 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players add #pigeons_joueurs sgp.dummy 1
scoreboard players set #pigeons_ticks sgp.timer 0
scoreboard players set #pigeons_secondes sgp.timer 0
scoreboard players set #pigeons_minutes sgp.timer 0
scoreboard players set #chasseurs_tues sgp.dummy 0
function sgp.mineurs:common/stop
scoreboard players enable @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] sgp.devenir_chasseur
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run function sgp.kits:misc/sort_salle
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title [{"text":"Chasse au sgp.Pigeons","color":"gray","bold":true}]
tag @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] remove tag1
statuswarp pvp disabled
move @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] #Pigeons
function sgp.lore:npcs/disable