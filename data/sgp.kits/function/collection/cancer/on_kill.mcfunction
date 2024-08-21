#> sgp.kits:collection/cancer/on_kill
# 
# Gives the Cancer kill rewards

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'tipped_arrow[ \
        custom_name=\'{"text":"Flèche de Lévitation", "color":"dark_red", "italic":false, "bold":true}\', \
        lore=[ \
            \'{"text":"⟰ Lévitation IV (0:13)", "color":"#F2F3F4", "italic":false}\' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"levitation", amplifier:3, duration:256} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]', \
    give_2:'tipped_arrow[ \
        custom_name=\'{"text":"Flèche de Lenteur", "color":"dark_red", "italic":false, "bold":true}\', \
        lore=[ \
            \'{"text":"⬳ Lenteur IV (0:26)", "color":"#555555", "italic":false}\' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"slowness", amplifier:3, duration:512} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]', \
    actionbar:' \
        {"text":"+ 1 ⟰ Flèche de Lévitation ", "color":"#F2F3F4", "bold":true}, \
        {"text":"et 1 ⬳ Flèche de Lenteur !", "color":"#555555"} \
        ' \
    }

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run give @s golden_apple[ \
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

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    give: 'splash_potion[ \
        "minecraft:custom_name":\'{"bold":true,"color":"dark_red","italic":false,"text":"Potion de Rapidité"}\', \
        "minecraft:lore": [ \
            \'{"color":"aqua","italic":false,"text":"➠ Rapidité II (0:15)"}\' \
            ], \
        "minecraft:potion_contents":{ \
            custom_effects: [ \
                {duration:300, id:"minecraft:speed", amplifier:1b, } \
                ] \
            }, \
        "minecraft:hide_additional_tooltip":{} \
        ,max_stack_size=64 \
        ] 1', \
    give_2: 'splash_potion["minecraft:custom_name":\'{"bold":true,"color":"dark_red","italic":false,"text":"Potion de Rapidité"}\', \
        "minecraft:lore": [ \
            \'{"color":"green","italic":false,"text":"⇪ Sauts améliorés III (0:30)"}\' \
            ], \
        "minecraft:potion_contents":{ \
            custom_effects: [ \
                {duration:600, id:"minecraft:jump_boost", amplifier:2b, } \
                ] \
            }, \
        "minecraft:hide_additional_tooltip":{} \
        ,max_stack_size=64 \
        ] 1', \
    actionbar:' \
        {"text":"+ 1 ❤ Pomme d\'or, ", "color":"yellow", "bold":true}, \
        {"text":"1 ⟰ Flèche de Lévitation, ", "color":"white"}, \
        {"text":"1 ⬳ Flèche de Lenteur, ", "color":"#555555"}, \
        {"text":"1 ➠ Potion de Rapidité ", "color":"aqua"}, \
        {"text":"et 1 ⇪ Potion de Saut !", "color":"green"} ', \
    nb:2 }