#> sgp.kits:collection/items/archer
# 
# Gives the items of the Archer kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with wooden_sword[\
    custom_name='{"text":"Épée d\'Entraînement", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"4 dégats", "color":"blue", "italic":false}' \
        ], \
    attribute_modifiers={ \
        modifiers: [\
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:4.0, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name='{"text":"Arc d\'Élite", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🏹 Puissance III", "color":"dark_red", "italic":false}', \
        '{"text":"⬱ Recul I", "color":"#6F4E37", "italic":false}', \
        '{"text":"∞ Infinité", "color":"#E5E4E2", "italic":false}' \
        ], \
    enchantments={ \
        levels: {infinity:1, power:3, punch:1}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with leather_helmet[ \
    custom_name='{"text":"Chapeau en Cuir", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}'], \
    enchantments={ \
        levels: {protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:9633536, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"coast", \
        material:"quartz", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false}, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with chainmail_chestplate[\
    custom_name='{"text":"Cotte de Mailles", "color":"green", "italic":false, "bold":true}', \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false}, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Pantalon en Cuir", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:9633536, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"spire", \
        material:"quartz", \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name='{"text":"Bottes en Cuir", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:9633536, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"spire", \
        material:"quartz", \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.4 with arrow

item replace entity @s hotbar.5 with tipped_arrow[ \
    custom_name='{"text":"Flèche de Lenteur", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⬳ Lenteur II (1:28)", "color":"#555555", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:1, duration:1760} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ] 2

item replace entity @s weapon.offhand with tipped_arrow[ \
    custom_name='{"text":"Flèche de Poison", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"☠ Poison (0:11)", "color":"#55741B", "italic":false}' \
        ], \
    potion_contents="long_poison", \
    hide_additional_tooltip={} \
    ] 5


# ---------- FOOD ----------
item replace entity @s hotbar.3 with cooked_beef[ \
    custom_name='{"text":"Steak", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"green", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ] 3