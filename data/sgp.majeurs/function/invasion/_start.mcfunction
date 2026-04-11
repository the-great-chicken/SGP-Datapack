#> sgp.majeurs:invasion/_start
# 
# Start the major event Invasion

tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Lancement d'Invasion...", color:dark_blue, bold:true}]

function sgp.majeurs:common/start

function sgp.majeurs:invasion/dispatch
execute as @a[team=sgp.Defenseur] run function sgp.kits:give {kit:tank}
tp @a[team=sgp.Defenseur] 2496.0 251.0 2159.0
scoreboard players set #invasion_secondes sgp.timer 0
scoreboard players set #invasion_ticks sgp.timer 0
scoreboard players set #invasion_joueurs sgp.dummy 0
execute as @a[tag=sgp.in_game] run scoreboard players add #invasion_joueurs sgp.dummy 1
scoreboard players operation #invasion_joueurs sgp.dummy *= 16 sgp.dummy
experience set @a[tag=sgp.in_game] 0 levels
execute as @a[tag=sgp.in_game] run experience add @a[tag=sgp.in_game] 16 levels

title @a[team=sgp.Defenseur] title [{text:"Vous êtes Défenseur", color:blue, bold:true}]
title @a[team=sgp.Attaquant] title [{text:"Vous êtes sgp.Attaquant", color:red, bold:true}]
move @a[team=sgp.Defenseur] #Défenseurs
move @a[team=sgp.Attaquant] #Attaquants

targetglow @a[team=sgp.Attaquant] @a[gamemode=survival,team=sgp.Attaquant] RED
targetglow @a[team=sgp.Defenseur] @a[gamemode=survival,team=sgp.Defenseur] BLUE

give @a[team=sgp.Defenseur] potion[ \
    custom_name={text:"Potion du Maitre Tortue", color:dark_blue, italic:false, bold:true}, \
    lore=[ \
        {text:"🛡 Résistance IV (0:20)", color:"#536878", italic:false}, \
        {text:"⬳ Lenteur VI (0:20)", color:"#555555", italic:false} \
        ], \
    potion_contents="strong_turtle_master", \
    tooltip_display={hidden_components:["potion_contents"]}, \
    ] 3

effect give @a[tag=sgp.in_game] minecraft:saturation 10 2
fill 2495 253 2164 2495 243 2164 air

item replace entity @a[team=sgp.Defenseur] hotbar.7 with tipped_arrow[ \
    custom_name={text:"Flèche du Maitre Tortue", color:dark_blue, italic:false, bold:true}, \
    lore=[ \
        {text:"🛡 Résistance II (0:08)", color:"#536878", italic:false}, \
        {text:"⬳ Lenteur IV (0:08)", color:"#555555", italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:5, duration:160}, \
            {id:"resistance", amplifier:1, duration:160} \
            ] \
        }, \
    potion_duration_scale=1.0, \
    tooltip_display={hidden_components:["potion_contents"]}, \
    ] 10