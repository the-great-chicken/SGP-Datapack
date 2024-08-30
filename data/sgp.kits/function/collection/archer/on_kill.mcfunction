#> sgp.kits:collection/archer/on_kill
# 
# Gives the Archer kill rewards

execute as @a[tag=sgp.archer,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'tipped_arrow[ \
        custom_name=\'{"text":"Flèche de Poison", "color":"green", "italic":false, "bold":true}\', \
        lore=[ \
            \'{"text":"☠ Poison (0:11)", "color":"#55741B", "italic":false}\' \
            ], \
        potion_contents="long_poison", \
        hide_additional_tooltip={} \
        ]', \
    give_2:air, \
    actionbar:'{"text":"+ 1 ☠ Flèche de Poison !", "color":"#55741B", "bold":true}' \
    }

execute as @a[tag=sgp.archer,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2,  \
    give:'tipped_arrow[ \
        custom_name=\'{"text":"Flèche de Lenteur", "color":"green", "italic":false, "bold":true}\', \
        lore=[ \
            \'{"text":"⬳ Lenteur II (1:28)", "color":"#555555", "italic":false}\' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"slowness", amplifier:1, duration:1760} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]', \
    give_2:air, \
    actionbar:' \
        {"text":"+ 1 ☠ Flèche de Poison ", "color":"#55741B", "bold":true}, \
        {"text":"et 1 ⬳ Flèche de Lenteur !", "color":"#555555"}' \
    }

execute as @a[tag=sgp.archer,scores={sgp.kills_give_3=3..}] run function sgp.kits:kills_give/basic { \
    nb:3, \
    give:'golden_apple[ \
        custom_name=\'{"text":"Pomme d\\\'or", "color":"green", "italic":false, "bold":true}\', \
        lore=[ \
            \'[ \
                {"text":"Régénère jusqu\\\'à 6", "color":"gray", "italic":false}, \
                {"text":"❤", "color":"red"}, \
                {"text":" + 2"}, \
                {"text":"❤", "color":"yellow"} \
                ]\' \
            ] \
        ]', \
    give_2:air, \
    actionbar:' \
        {"text":"+ 1 ☠ Flèche de Poison ", "color":"green", "bold":true}, \
        {"text":"et 1 ❤ Pomme d\\\'or !", "color":"yellow"} \
        ' \
    }