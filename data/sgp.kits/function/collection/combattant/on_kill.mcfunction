#> sgp.kits:collection/combattant/on_kill
# 
# Gives the Combattant kill rewards

execute as @a[tag=sgp.combattant,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow 3", \
    give_2:air, \
    actionbar:'{"text":"+ 3 ➶ Flèches !", "color":"gray", "bold":true}' \
    }

execute as @a[tag=sgp.combattant,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:'golden_apple[ \
        custom_name=\'{"text":"Pomme d\\\'or", "color":"white", "italic":false, "bold":true}\', \
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
        {"text":"+ 3 ➶ Flèches ", "color":"gray", "bold":true}, \
        {"text":"et 1 ❤ Pomme d\\\'or !", "color":"yellow"} \
        ' \
    }