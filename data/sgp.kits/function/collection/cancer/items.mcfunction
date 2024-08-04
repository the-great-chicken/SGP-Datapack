#> sgp.kits:collection/cancer/items
# 
# Gives the items of the Cancer kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stick[ \
    custom_name='{"text":"Bâton Cancérigène", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant XII", "color":"dark_red", "italic":false}', \
        '{"text":"⬱ Recul IV", "color":"#6F4E37", "italic":false}', \
        '{"text":"7,5 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {knockback:4, sharpness:12}, \
        show_in_tooltip:false}, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        } \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name='{"text":"Arc Cancérigène", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🔥 Flamme", "color":"#FF8C00", "italic":false}', \
        '{"text":"⬱ Recul IV", "color":"#6F4E37", "italic":false}' \
        ], \
    enchantments={ \
        levels: {punch:4, flame:1}, \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with leather_helmet[ \
    custom_name='{"text":"Chapeau en Cuir", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"vex", \
        material:"redstone", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with golden_chestplate[ \
    custom_name='{"text":"Plastron en Or", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"---------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}', \
        '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:2, thorns:3, projectile_protection:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"vex", \
        material:"redstone", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Pantalon en Cuir", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"tide", \
        material:"redstone", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name='{"text":"Bottes en Cuir", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"spire", \
        material:"redstone", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.3 with tipped_arrow[ \
    custom_name='{"text":"Flèche de Lévitation", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"⟰ Lévitation IV (0:13)", "color":"#F2F3F4", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"levitation", amplifier:3, duration:256} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ] 5

item replace entity @s hotbar.4 with tipped_arrow[ \
    custom_name='{"text":"Flèche de Lenteur", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"⬳ Lenteur IV (0:26)", "color":"#555555", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:3, duration:512} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ] 5

function sgp.kits:stacking/set_stack { \
    item_id:splash_potion, count:3, slot:hotbar.5, tag: " \
        custom_name:'{\"text\":\"Potion de Rapidité\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore:[ \
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

function sgp.kits:stacking/set_stack { \
    item_id:splash_potion, count:3, slot:hotbar.6, tag:" \
        custom_name:'{\"text\":\"Potion de Saut\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore:[ \
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


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name='{"text":"Steak", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"dark_red", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ] 4