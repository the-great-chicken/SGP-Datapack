#> sgp.kits:collection/enderman/items
# 
# Gives the items of the Enderman kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with diamond_sword[ \
    custom_name='{"text":"Épée en \'\'Diamant\'\'", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"❊ Affilage III", "color":"#ADDBD9", "italic":false}', \
        '{"text":"6 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {sweeping_edge:3}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:6.0, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

# ---------- ARMOR ----------
item replace entity @s armor.head with player_head[ \
    custom_name='{"text":"Tête", "color":"dark_purple", "italic":false, "bold":true}', \
    profile="kaamaru", \
    enchantments={ \
        levels: {binding_curse:1, "sgp.kits:water_damage":1}, \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with leather_chestplate[ \
    custom_name='{"text":"Corps", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:3, projectile_protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:0, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"eye", \
        material:"amethyst", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Jambes", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:3, projectile_protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:0, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"dune", \
        material:"amethyst", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name='{"text":"Pieds", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:3, projectile_protection:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:0, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"raiser", \
        material:"amethyst", \
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
    custom_name='{"text":"Potion de Rapidité", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"➠ Rapidité II (0:22)", "color":"aqua", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"speed", amplifier:1, duration:440} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ]

item replace entity @s hotbar.1 with ender_pearl[ \
    custom_name='{"text":"Yeux", "color":"dark_purple", "italic":false, "bold":true}' \
    ] 8


# ---------- FOOD ----------
item replace entity @s weapon.offhand with chorus_fruit[ \
    custom_name='{"text":"Chorus", "color":"dark_purple", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 2", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 64