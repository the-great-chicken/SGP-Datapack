#> sgp.kits:collection/pyromane/on_kill
# 
# Gives the Pyromane kill rewards

execute as @a[tag=sgp.pyromane,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow", \
    give_2:'firework_rocket[ \
        custom_name=\'{"text":"Explosifs", "color":"red", "italic":false, "bold":true}\', \
        fireworks={ \
            explosions: [ \
                {shape:"large_ball", colors: [I;11743532,15435844], fade_colors: [I;14602026,15435844], has_twinkle:true}, \
                {shape:"large_ball", colors: [I;11743532,15435844], fade_colors: [I;14602026,15435844], has_twinkle:true} \
                ], \
            flight_duration:-2,\
            show_in_tooltip:false \
            }, \
        hide_additional_tooltip={} \
        ] 2', \
    actionbar:' \
        {"text":"+ 1 ➶ Flèche ", "color":"gray", "bold":true}, \
        {"text":"et 2 ☀ Explosifs !", "color":"red"} \
        ' \
    }

execute as @a[tag=sgp.pyromane,scores={sgp.kills_give_2=3..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:'golden_apple[ \
        custom_name=\'{"text":"Pomme d\\\'or", "color":"gold", "italic":false, "bold":true}\', \
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
        {"text":"+ 1 ➶ Flèche, ","color":"gray", "bold":true}, \
        {"text":"2 ☀ Explosifs ", "color":"red"}, \
        {"text":"et 1 ❤ Pomme d\\\'or !", "color":"yellow"} \
        ', \
    }
