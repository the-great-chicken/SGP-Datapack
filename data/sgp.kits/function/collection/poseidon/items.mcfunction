#> sgp.kits:collection/poseidon/items
# 
# Gives the items of the Poseidon kit to the player

# ---------- WEAPONS ----------
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
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:7.5, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ] 17

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