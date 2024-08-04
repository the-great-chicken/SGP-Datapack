#> sgp.kits:collection/vindicateur/items
# 
# Gives the items of the Vindicateur kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with iron_axe[ \
    custom_name='{"text":"Hache usée", "color":"dark_green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"7 dégats", "color":"blue", "italic":false}' \
        ], \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:7, operation:"add_value"}, \
            ], \
        show_in_tooltip:false}, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with iron_helmet[ \
    custom_name='{"text":"Casque en Fer", "color":"dark_green", "italic":false, "bold":true}', \
    trim={ \
        pattern:"rib", \
        material:"copper", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with diamond_chestplate[ \
    custom_name='{"text":"Plastron en Diamant", "color":"dark_green", "italic":false, "bold":true}', \
    trim={ \
        pattern:"rib", \
        material:"copper", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Pantalon en Cuir", "color":"dark_green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines I", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:1}, \
        show_in_tooltip:false}, \
    dyed_color={ \
        rgb:9533531, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"rib", \
        material:"copper", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name='{"text":"Bottes en Cuir", "color":"dark_green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {thorns:3, "sgp.kits:depth_strider_boosted":1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:9533531, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"rib", \
        material:"copper", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.2 with splash_potion[ \
    custom_name='{"text":"Potion de Faiblesse", "color":"dark_green", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"⬊ Faiblesse I (0:05)", "color":"#777075", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"weakness", amplifier:0, duration:100} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ]


# ---------- FOOD ----------
item replace entity @s hotbar.3 with cooked_beef[ \
    custom_name='{"text":"Steak", "color":"dark_green", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 32