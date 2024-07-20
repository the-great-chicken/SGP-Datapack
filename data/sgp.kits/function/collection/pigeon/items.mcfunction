#> sgp.kits:collection/pigeon/items
# 
# Gives the items of the Pigeon kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with feather[ \
    custom_name='{"text":"Plume", "color":"dark_gray", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant V", "color":"dark_red", "italic":false}', \
        '{"text":"⬱ Recul III", "color":"#6F4E37", "italic":false}', \
        '{"text":"4 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {knockback:3, sharpness:5}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s hotbar.1 with bow[ \
    unbreakable={show_in_tooltip:false}, \
    enchantments={ \
        levels: {power:2, infinity:1}, \
        show_in_tooltip:false \
        }, \
    custom_name='{"text":"Lance Plumes", "color":"dark_gray", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🏹 Puissance II", "color":"dark_red", "italic":false}', \
        '{"text":"∞ Infinité", "color":"#E5E4E2", "italic":false}' \
        ] \
    ]



# ---------- ARMOR ----------
item replace entity @s armor.head with player_head[ \
    custom_name='{"text":"Tête", "color":"dark_gray", "italic":false, "bold":true}', \
    profile="__pif__", \
    enchantments={ \
        levels: {binding_curse:1}, \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with elytra[ \
    custom_name='{"text":"Ailes", "color":"dark_gray", "italic":false, "bold":true}', \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with chainmail_leggings[ \
    custom_name='{"text":"Cuisses", "color":"dark_gray", "italic":false, "bold":true}', \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with chainmail_boots[ \
    custom_name='{"text":"Pattes", "color":"dark_gray", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:2}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- MISC ----------
item replace entity @s inventory.8 with arrow[ \
    custom_name='{"text":"uwu", "italic":false}' \
    ]

item replace entity @s hotbar.2 with firework_rocket[ \
    custom_name='{"text":"Boost", "color":"dark_gray", "italic":false, "bold":true}', \
    ] 5


# ---------- FOOD ----------
item replace entity @s weapon.offhand with bread[ \
    custom_name='{"text":"Miettes", "color":"dark_gray", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 64