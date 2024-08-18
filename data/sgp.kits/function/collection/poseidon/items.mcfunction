#> sgp.kits:collection/poseidon/items
# 
# Gives the items of the Poseidon kit to the player

# ---------- WEAPONS ----------
give @s trident[ \
    custom_name='{"text":"Le Trident", "color":"dark_aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚡ Impulsion I", "color":"yellow", "italic":false}', \
        '{"text":"7,5 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {riptide:1}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:7.5, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

give @s trident[ \
    custom_name='{"text":"Trident", "color":"dark_aqua", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"---------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"7,5 dégats", "color":"blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {impaling:4}, \
        show_in_tooltip:false \
        }, \
    enchantment_glint_override=false, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:7.5, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ] 17


# ---------- ARMOR ----------
item replace entity @s armor.feet with chainmail_boots[ \
    custom_name='{"text":"Palmes", "color":"dark_aqua", "italic":false, "bold":true}', \
    enchantments={ \
        levels: {"sgp.kits:depth_strider_boosted":25}, \
        show_in_tooltip:false \
    }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.armor", amount:-1, id:"armor", operation:"add_multiplied_total", slot:armor} \
        ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_cod[ \
    custom_name='{"text":"Morue", "color":"dark_aqua", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 2,5", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 64