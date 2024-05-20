tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement d'Invasion...", "color":"dark_blue", "bold":true}]
function mineurs:stop
function majeurs:invasion_dispatch
execute as @a[team=Defenseur] run function kits:tank
tp @a[team=Defenseur] 2496.0 251.0 2159.0
scoreboard players set @a[team=Attaquant] entre_kits 1
scoreboard players set #invasion_secondes timer 0
scoreboard players set #invasion_ticks timer 0
scoreboard players set #invasion_joueurs dummy 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players add #invasion_joueurs dummy 1
scoreboard players operation #invasion nbr_de_joueurs *= 16 dummy
experience set @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] 0 levels
execute as @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] run experience add @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] 16 levels
statuswarp pvp disabled
title @a[team=Defenseur] title [{"text":"Vous êtes Défenseur", "color":"blue", "bold":true}]
title @a[team=Attaquant] title [{"text":"Vous êtes Attaquant", "color":"red", "bold":true}]
move @a[team=Defenseur] #Défenseurs
move @a[team=Attaquant] #Attaquants
sudo Bafy78 useglow toggle
targetglow @a[team=Attaquant] @a[gamemode=survival,team=Attaquant] RED
targetglow @a[team=Defenseur] @a[gamemode=survival,team=Defenseur] BLUE
give @a[team=Defenseur] minecraft:potion{Potion:"minecraft:strong_turtle_master", HideFlags:63, display:{Name:'{"text":"Potion du Maitre Tortue", "color":"dark_blue", "italic":false, "bold":true}',Lore:['{"text":"------------------------", "color":"#C0C0C0", "italic":false}','{"text":"🛡 Résistance IV (0:20)", "color":"#536878", "italic":false}','{"text":"⬳ Lenteur VI (0:20)", "color":"#555555", "italic":false}']}} 3
effect give @a minecraft:saturation 10 2
fill 2495 253 2164 2495 243 2164 air
item replace entity @a[team=Defenseur] hotbar.7 with minecraft:tipped_arrow{custom_potion_effects:[{id:"slowness", amplifier:5, duration:60}], CustomPotionColor:14875096, HideFlags:32, display:{Name:'{"text":"Flèche de Lenteur", "color":"dark_blue", "italic":false, "bold":true}',Lore:['{"text":"------------------------", "color":"#C0C0C0", "italic":false}','{"text":"⬳ Lenteur IV (0:03)", "color":"#555555", "italic":false}']}} 10
function lore:disable_npcs