#> sgp.kits:collection/eclaireur/items
# 
# Gives the items of the Eclaireur kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stone_sword[ \
    custom_name='{"text":"Épée en Pierre", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"---------------", "color":"gray", "italic":false}', \
        '{"text":"5 dégats", "color":"blue", "italic":false}' \
        ], \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:5.0, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s hotbar.1 with crossbow[\
    custom_name='{"text":"Arbalète", "color":"aqua", "italic":false, "bold":true}', \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with leather_helmet[ \
    custom_name='{"text":"Chapeau en Cuir", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines II", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"raiser", \
        material:"emerald", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with leather_chestplate[ \
    custom_name='{"text":"Tunique en Cuir", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines II", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"raiser", \
        material:"emerald", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Pantalon en Cuir", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines II", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"raiser", \
        material:"emerald", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with diamond_boots[ \
    custom_name='{"text":"Bottes d\'Exploration", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines II", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:2, "sgp.kits:depth_strider_boosted":1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
    pattern:"raiser", \
    material:"emerald", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

# ---------- MISC ----------
item replace entity @s hotbar.7 with arrow 3
item replace entity @s hotbar.6 with spyglass


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name='{"text":"Steak", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"aqua", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ] 6