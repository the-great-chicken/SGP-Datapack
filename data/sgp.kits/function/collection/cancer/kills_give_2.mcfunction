#> sgp.kits:collection/cancer/kills_give_2
# 
# Gives the reward for each kill as a Cancer: potions that get stacked
# to existing ones in the player's inventory + a golden apple

function sgp.kits:stacking/add_count_to_stack { \
    item_id:splash_potion, \
    count:1, \
    tag:" \
        custom_name:'{\"text\":\"Potion de Rapidité\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore:[ \
            '{\"text\":\"------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"➠ Rapidité II (0:15)\", \"color\":\"aqua\", \"italic\":false}' \
            ], \
        potion_contents:{ \
            custom_effects: [ \
                {id:\"speed\", amplifier:1, duration:300} \
                ] \
            }, \
        hide_additional_tooltip:{} \
        " \
    }

function sgp.kits:stacking/add_count_to_stack { \
    item_id:splash_potion, \
    count:1, \
    tag:" \
        custom_name:'{\"text\":\"Potion de Saut\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore:[ \
            '{\"text\":\"-----------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"⇪ Sauts améliorés III (0:30)\", \"color\":\"green\", \"italic\":false}' \
            ], \
        potion_contents:{ \
            custom_effects: [ \
                {id:\"jump_boost\", amplifier:2, duration:600} \
                ] \
            }, \
        hide_additional_tooltip:{} \
        " \
    }

give @s golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ]

data modify storage smithed.actionbar:input message set value { \
    json:'[ \
        {"text":"+ 1 ❤ Pomme d\'or, ", "color":"yellow", "bold":true}, \
        {"text":"1 ⟰ Flèche de Lévitation, ", "color":"white"}, \
        {"text":"1 ⬳ Flèche de Lenteur, ", "color":"#555555"}, \
        {"text":"1 ➠ Potion de Rapidité ", "color":"aqua"}, \
        {"text":"et 1 ⇪ Potion de Saut !", "color":"green"} \
        ]', \
    priority:'notification' \
    }

execute as @s run function #smithed.actionbar:message
scoreboard players set @s sgp.kills_give_2 0