#> sgp.kits:collection/eclaireur/on_kill
# 
# Gives the Éclaireur kill rewards

execute as @a[tag=sgp.eclaireur,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow 2", \
    give_2:'golden_apple[ \
        custom_name=\'{"text":"Pomme d\\\'or", "color":"aqua", "italic":false, "bold":true}\', \
        lore=[ \
            \'[ \
                {"text":"Régénère jusqu\\\'à 6", "color":"gray", "italic":false}, \
                {"text":"❤", "color":"red"}, \
                {"text":" + 2"}, \
                {"text":"❤", "color":"yellow"} \
                ]\' \
            ] \
        ] 2', \
    actionbar:' \
        {"text":"+ 2 ➶ Flèches ", "color":"gray", "bold":true}, \
        {"text":"et 2 ❤ Pommes d\\\'or !", "color":"yellow"} \
        ' \
    }