#> sgp.kits:collection/alchimiste/items
# 
# Gives the items of the Alchimiste kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stone_sword[ \
    custom_name='{"text":"Épée en Pierre", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"---------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant I", "color":"dark_red", "italic":false}', \
        '{"text":"6 dégats", "color":"blue", "italic":false}' \
        ], \
   enchantments={ \
        levels: {sharpness:1}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:5.0, operation:"add_value"} \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with chainmail_helmet[ \
    custom_name='{"text":"Casque de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"tide", \
        material:"amethyst", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.chest with chainmail_chestplate[ \
    custom_name='{"text":"Cotte de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, projectile_protection:2}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"sentry", \
        material:"amethyst", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with chainmail_leggings[ \
    custom_name='{"text":"Jambières de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"--------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:"sentry", \
        material:"amethyst", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.feet with minecraft:chainmail_boots[ \
    custom_name='{"text":"Bottes de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}' \
        ], \
    enchantments={ \
        levels: {protection:1, "sgp.kits:depth_strider_boosted":1}, \
        show_in_tooltip:false \
        }, \
    trim={ \
        pattern:'sentry', \
        material:'amethyst', \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]


# ---------- MISC ----------
function sgp.kits:stacking/set_stack { \
    item_id:splash_potion, count:8, slot:hotbar.1, tag:" \
        custom_name:'{\"text\":\"Potion de Soin\", \"color\":\"light_purple\", \"italic\":false,\"bold\":true}', \
        lore:[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 2\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" instantanément\"} \
                ]' \
            ], \
        potion_contents:\"minecraft:healing\", \
        hide_additional_tooltip:{} \
        " \
    }

function sgp.kits:stacking/set_stack { \
    item_id:splash_potion, count:10, slot:hotbar.2, tag:" \
        custom_name:'{\"text\":\"Potion de Dégats\", \"color\":\"light_purple\", \"italic\":false, \"bold\":true}', \
        lore:[ \
            '{\"text\":\"Inflige jusqu\\'à 4 dégâts\", \"color\":\"gray\", \"italic\":false}' \
            ], \
        potion_contents:\"minecraft:harming\", \
        hide_additional_tooltip:{} \
        " \
    }

item replace entity @s hotbar.3 with splash_potion[ \
    custom_name='{"text":"Potion de Cécité", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"👁 Cécité (0:05)", "color":"#8B8589", "italic":false}' \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"blindness", amplifier:0, duration:100} \
            ] \
        }, \
    hide_additional_tooltip={} \
    ]

item replace entity @s hotbar.4 with milk_bucket[ \
    custom_name='{"text":"Antibiotique", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"Enlève tous les effets", "color":"gray", "italic":false}' \
        ] \
    ]


# ---------- FOOD ----------
item replace entity @s weapon.offhand with baked_potato[ \
    custom_name='{"text":"Pommes de Terre cuites au Four", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"} \
            ]' \
        ] \
    ] 64