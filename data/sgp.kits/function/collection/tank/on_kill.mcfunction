#> sgp.kits:collection/tank/on_kill
# 
# Gives the Tank kill rewards

execute as @a[tag=sgp.tank,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'golden_apple[ \
        custom_name={text:"Pomme d\'or", color:dark_blue, italic:false, bold:true}, \
        lore=[ \
            [ \
                {text:"Régénère jusqu\'à 6", color:gray, italic:false}, \
                {text:"❤", color:red}, \
                {text:" + 2"}, \
                {text:"❤", color:yellow} \
                ] \
            ] \
        ]', \
    give_2:'tipped_arrow[ \
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
        tooltip_display={hidden_components:["potion_contents"]}, \
        ]', \
    actionbar:' \
        {text:"+ 1 ➶ Flèche ", color:"#545F67", bold:true}, \
        {text:"et 1 ❤ Pomme d\'or !", color:yellow} \
        ' \
    }

execute as @a[tag=sgp.tank,scores={sgp.kills_give_2=3..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:'potion[ \
        custom_name={text:"Potion du Maitre Tortue", color:dark_blue, italic:false, bold:true}, \
        lore=[ \
            {text:"🛡 Résistance IV (0:20)", color:"#536878", italic:false}, \
            {text:"⬳ Lenteur VI (0:20)", color:"#555555", italic:false} \
            ], \
        potion_contents="strong_turtle_master", \
        tooltip_display={hidden_components:["potion_contents"]}, \
        ]', \
    give_2:air, \
    actionbar:' \
        {text:"+ 1 ➶ Flèche, ", color:"#545F67", bold:true}, \
        {text:"1 🧪 Potion ", color:dark_blue}, \
        {text:"et 1 ❤ Pomme d\'or !", color:yellow} \
        ' \
    }
