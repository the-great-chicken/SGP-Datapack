#> sgp.kits:collection/tank/items
# 
# Gives the items of the Tank kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with wooden_sword[ \
    custom_name='{"text":"Épée Abîmée", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⬱ Recul I", "color":"#6F4E37", "italic":false}', \
        '{"text":"3,5 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {knockback:1}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:3.5, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name='{"text":"Arc", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⬱ Recul I", "color":"#6F4E37", "italic":false}' \
        ], \
    enchantments={ \
        levels: {punch:1}, \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with diamond_helmet[ \
    custom_name='{"text":"Casque en Diamant", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"᠅ Épines I", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, thorns:1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"sentry", \
        material:"netherite", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with iron_chestplate[ \
    custom_name='{"text":"Plastron en Fer", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, projectile_protection:1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"dune", \
        material:"netherite", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with iron_leggings[ \
    custom_name='{"text":"Jambières en Fer", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, projectile_protection:1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"dune", \
        material:"netherite", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with diamond_boots[ \
    custom_name='{"text":"Bottes en Diamant", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"᠅ Épines I", "color":"dark_green", "italic":false}', \
        '{"text":""}', \
        '{"text":"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", "color":"#4040EA", "italic":false}', \
        '[ \
            {"text":"» ", "color":"yellow", "italic":false}, \
            {"text":"Vous n\'êtes pas", "color":"white"} \
            ]', \
        '[ \
            {"text":"ralenti dans l\'", "color":"white", "italic":false}, \
            {"text":"eau", "color":"#55D5F0"} \
            ]', \
        '{"text":"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", "color":"#4040EA", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, thorns:1, "sgp.kits:depth_strider_boosted":1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"tide", \
        material:"netherite", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- FOOD ----------
item replace entity @s hotbar.3 with cooked_beef[ \
    custom_name='{"text":"Steak", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ] 3


# ---------- MISC ----------
item replace entity @s hotbar.7 with tipped_arrow[ \
    custom_name='{"text":"Flèche du Maitre Tortue", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"🛡 Résistance II (0:08)", "color":"#536878", "italic":false}', \
        '{"text":"⬳ Lenteur IV (0:08)", "color":"#555555", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:5, duration:160}, \
            {id:"resistance", amplifier:1, duration:160} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ] 5

give @s potion[ \
    custom_name='{"text":"Potion du Maitre Tortue", "color":"dark_blue", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"🛡 Résistance IV (0:20)", "color":"#536878", "italic":false}', \
        '{"text":"⬳ Lenteur VI (0:20)", "color":"#555555", "italic":false}' \
        ], \
    potion_contents="strong_turtle_master", \
    hide_additional_tooltip={} \
    ] 3

item replace entity @s weapon.offhand with shield[ \
    custom_name='{"text":"Bouclier", "color":"dark_blue", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {thorns:1}, show_in_tooltip:false \
        }, \
    base_color="black", \
    banner_patterns=[ \
        {color:"light_blue", pattern:"rhombus"}, \
        {color:"blue", pattern:"circle"}, \
        {color:"black", pattern:"flower"}, \
        {color:"blue", pattern:"gradient_up"}, \
        {color:"cyan", pattern:"gradient"}, \
        ], \
    hide_additional_tooltip={}, \
    unbreakable={show_in_tooltip:false} \
    ]