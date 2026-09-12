#> sgp.kits:collection/tank/on_kill
# 
# Gives the Tank kill rewards

execute if score @s sgp.kills_give_1 matches 1.. run function sgp.kits:kills_give/basic { \
    nb:1, threshold:1, \
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
        potion_duration_scale=1.0, \
        tooltip_display={hidden_components:["potion_contents"]}, \
        ]', \
    actionbar:' \
        {text:"+ 1 ➶ Flèche ", color:"#545F67", bold:true}, \
        {text:"et 1 ❤ Pomme d\\\'or !", color:yellow} \
        ', \
    width:391, \
    }

execute if score @s sgp.kills_give_2 matches 3.. run function sgp.kits:kills_give/basic { \
    nb:2, threshold:3, \
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
    actionbar:{text:"+ 1 🧪 Potion !", color:dark_blue, bold:true}, \
    width:164, \
    }

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 1.. run return run function sgp.kits:collection/tank/on_kill
execute if score @s sgp.kills_give_2 matches 3.. run return run function sgp.kits:collection/tank/on_kill
