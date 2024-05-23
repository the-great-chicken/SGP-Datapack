tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement d'Invasion...", "color":"dark_blue", "bold":true}]
function sgp.mineurs:common/stop
function sgp.majeurs:invasion/dispatch
execute as @a[team=sgp.Defenseur] run function sgp.kits:collection/tank
tp @a[team=sgp.Defenseur] 2496.0 251.0 2159.0
scoreboard players set @a[team=sgp.Attaquant] sgp.entre_kits 1
scoreboard players set #invasion_secondes sgp.timer 0
scoreboard players set #invasion_ticks sgp.timer 0
scoreboard players set #invasion_joueurs sgp.dummy 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players add #invasion_joueurs sgp.dummy 1
scoreboard players operation #invasion nbr_de_joueurs *= 16 sgp.dummy
experience set @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] 0 levels
execute as @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] run experience add @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] 16 levels
statuswarp pvp disabled
title @a[team=sgp.Defenseur] title [{"text":"Vous êtes Défenseur", "color":"blue", "bold":true}]
title @a[team=sgp.Attaquant] title [{"text":"Vous êtes sgp.Attaquant", "color":"red", "bold":true}]
move @a[team=sgp.Defenseur] #Défenseurs
move @a[team=sgp.Attaquant] #Attaquants
useglow toggle
targetglow @a[team=sgp.Attaquant] @a[gamemode=survival,team=sgp.Attaquant] RED
targetglow @a[team=sgp.Defenseur] @a[gamemode=survival,team=sgp.Defenseur] BLUE
give @a[team=sgp.Defenseur] minecraft:potion{Potion:"minecraft:strong_turtle_master", HideFlags:63, display:{Name:'{"text":"Potion du Maitre Tortue", "color":"dark_blue", "italic":false, "bold":true}',Lore:['{"text":"------------------------", "color":"#C0C0C0", "italic":false}','{"text":"🛡 Résistance IV (0:20)", "color":"#536878", "italic":false}','{"text":"⬳ Lenteur VI (0:20)", "color":"#555555", "italic":false}']}} 3
effect give @a minecraft:saturation 10 2
fill 2495 253 2164 2495 243 2164 air
item replace entity @a[team=sgp.Defenseur] hotbar.7 with minecraft:tipped_arrow{custom_potion_effects:[{id:"slowness", amplifier:5, duration:60}], CustomPotionColor:14875096, HideFlags:32, display:{Name:'{"text":"Flèche de Lenteur", "color":"dark_blue", "italic":false, "bold":true}',Lore:['{"text":"------------------------", "color":"#C0C0C0", "italic":false}','{"text":"⬳ Lenteur IV (0:03)", "color":"#555555", "italic":false}']}} 10
function sgp.lore:npcs/disable