#> sgp.majeurs:pco/kit
# `{color, color_material, color_hex}`
#
# Equip a player with a custom kit for the "Poule-Canard-Oie" game, including
# a feather weapon, bread for healing, and colored leather armor.

clear @s
effect clear @s

# ---------- WEAPON ----------
$item replace entity @s hotbar.0 with feather[ \
    custom_name='{"text":"Plume", "color":"$(color)", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant I", "color":"dark_red", "italic":false}', \
        '{"text":"4 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {unbreaking:0, sharpness:1}, \
        show_in_tooltip:false \
        } \
    ]


# ---------- ARMOR ----------
$item replace entity @s armor.head with leather_helmet[ \
    custom_name='{"text":"Tête", "color":"$(color)", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {binding_curse:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:$(color_hex), \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"sentry", \
        material:"$(color_material)", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

$item replace entity @s armor.chest with leather_chestplate[ \
    custom_name='{"text":"Corps", "color":"$(color)", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {binding_curse:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:$(color_hex), \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"snout", \
        material:"quartz", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

$item replace entity @s armor.legs with leather_leggings[ \
    custom_name='{"text":"Cuisses", "color":"$(color)", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {binding_curse:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:$(color_hex), \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"coast", \
        material:"quartz", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

$item replace entity @s armor.feet with leather_boots[ \
    custom_name='{"text":"Pattes", "color":"$(color)", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {binding_curse:1}, \
        show_in_tooltip:false \
        }, \
    dyed_color={ \
        rgb:$(color_hex), \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"wild", \
        material:"gold", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- FOOD ----------
$item replace entity @s weapon.offhand with bread[ \
    custom_name='{"text":"Miettes", "color":"$(color)", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red", "italic":false} \
            ]' \
        ] \
    ] 64

scoreboard players set @s sgp.reset_tags 1