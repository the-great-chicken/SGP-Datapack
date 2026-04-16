#> sgp.kits:collection/alchimiste/items
# 
# Gives the items of the Alchimiste kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stone_sword[ \
    custom_name={text:"Épée en Pierre", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"---------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant I", color:dark_red, italic:false}, \
        {text:"7 dégâts", color:blue, italic:false} \
        ], \
    enchantment_glint_override=true, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:6.0, operation:"add_value"} \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with chainmail_helmet[ \
    custom_name={text:"Casque de Mailles", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"------------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false} \
        ], \
    enchantments={protection:1}, \
    trim={ \
        pattern:"tide", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with chainmail_chestplate[ \
    custom_name={text:"Cotte de Mailles", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false} \
        ], \
    enchantments={protection:1, projectile_protection:2}, \
    trim={ \
        pattern:"sentry", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with chainmail_leggings[ \
    custom_name={text:"Jambières de Mailles", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false} \
        ], \
    enchantments={protection:1}, \
    trim={ \
        pattern:"sentry", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with minecraft:chainmail_boots[ \
    custom_name={text:"Bottes de Mailles", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:""}, \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false}, \
        [ \
            {text:"» ", color:yellow, italic:false}, \
            {text:"Vous n'êtes pas", color:white} \
            ], \
        [ \
            {text:"ralenti dans l'", color:white, italic:false}, \
            {text:"eau", color:"#55D5F0"} \
            ], \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false} \
        ], \
    enchantments={protection:1, "sgp.kits:depth_strider_boosted":1}, \
    trim={ \
        pattern:'sentry', \
        material:'amethyst', \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.1 with splash_potion[ \
    custom_name={text:"Potion de Soin", color:light_purple, italic:false,bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 2", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" instantanément"} \
            ] \
        ], \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    potion_contents="minecraft:healing", \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    max_stack_size=64 \
    ] 8

item replace entity @s hotbar.2 with splash_potion[ \
    custom_name={text:"Potion de Dégâts", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"Inflige jusqu'à 3", color:gray, italic:false, extra:[{text:"❤", color:red}, " instantanément"]} \
        ], \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    potion_contents="minecraft:harming", \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    max_stack_size=64 \
    ] 10

item replace entity @s hotbar.3 with splash_potion[ \
    custom_name={text:"Potion de Cécité", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"👁 Cécité (0:05)", color:"#8B8589", italic:false} \
        ], \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    potion_contents={ \
        custom_effects: [ \
            {id:"blindness", amplifier:0, duration:100} \
            ] \
        }, \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    max_stack_size=64 \
    ]

item replace entity @s hotbar.4 with milk_bucket[ \
    custom_name={text:"Antibiotique", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"Enlève tous les effets", color:gray, italic:false} \
        ] \
    ]


# ---------- FOOD ----------
item replace entity @s weapon.offhand with baked_potato[ \
    custom_name={text:"Pommes de Terre cuites au Four", color:light_purple, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 3", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 64