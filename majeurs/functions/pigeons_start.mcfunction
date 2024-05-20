tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement de la Chasse aux Pigeons...","color":"gray","bold":true}]
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] death_reset_tags 1
tp @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] 2409 251.5 2140 180 0
scoreboard players set #pigeons_joueurs dummy 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players add #pigeons_joueurs dummy 1
scoreboard players set #pigeons_ticks timer 0
scoreboard players set #pigeons_secondes timer 0
scoreboard players set #pigeons_minutes timer 0
scoreboard players set #chasseurs_tues dummy 0
function mineurs:stop
scoreboard players enable @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] devenir_chasseur
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run function kits:sort_salle_kits
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title [{"text":"Chasse au Pigeons","color":"gray","bold":true}]
tag @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] remove tag1
statuswarp pvp disabled
move @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] #Pigeons
function lore:disable_npcs