#> sgp.kits:collection/archer/on_kill
# 
# Gives the Archer kill rewards

execute if score @s sgp.kills_give_1 matches 1.. run function sgp.kits:kills_give/basic { \
    nb:1, threshold:1, \
    give:'tipped_arrow[ \
        custom_name={text:"Flèche de Poison", color:green, italic:false, bold:true}, \
        lore=[ \
            {text:"💀 Poison (0:11)", color:"#55741B", italic:false} \
            ], \
        potion_contents="long_poison", \
        tooltip_display= {hidden_components:["potion_contents"]}, \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 💀 Flèche de Poison !", color:"#55741B", bold:true}, \
    width:291, \
    }

execute if score @s sgp.kills_give_2 matches 2.. run function sgp.kits:kills_give/basic { \
    nb:2, threshold:2,  \
    give:'tipped_arrow[ \
        custom_name={text:"Flèche de Lenteur", color:green, italic:false, bold:true}, \
        lore=[ \
            {text:"⬳ Lenteur II (1:28)", color:"#555555", italic:false} \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"slowness", amplifier:1, duration:1760} \
                ] \
            }, \
        potion_duration_scale=1.0, \
        tooltip_display= {hidden_components:["potion_contents"]}, \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 ⬳ Flèche de Lenteur !", color:"#555555", bold:true}, \
    width:311, \
    }

execute if score @s sgp.kills_give_3 matches 3.. run function sgp.kits:kills_give/basic { \
    nb:3, threshold:3, \
    give:'golden_apple[ \
        custom_name={text:"Pomme d\'or", color:green, italic:false, bold:true}, \
        lore=[ \
            [ \
                {text:"Régénère jusqu\'à 6", color:gray, italic:false}, \
                {text:"❤", color:red}, \
                {text:" + 2"}, \
                {text:"❤", color:yellow} \
                ] \
            ] \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 ❤ Pomme d'or !", color:yellow, bold:true}, \
    width:222, \
    }

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 1.. run return run function sgp.kits:collection/archer/on_kill
execute if score @s sgp.kills_give_2 matches 2.. run return run function sgp.kits:collection/archer/on_kill
execute if score @s sgp.kills_give_3 matches 3.. run return run function sgp.kits:collection/archer/on_kill
