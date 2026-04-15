#> sgp.kits:collection/combattant/items
# 
# Gives the items of the Combattant kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with iron_sword[ \
    custom_name={text:"Épée en Fer", color:white, italic:false, bold:true}, \
    lore=[ \
        {text:"------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant I", color:dark_red, italic:false}, \
        {text:"7 dégats", color:blue, italic:false} \
        ], \
    enchantments={sharpness:1}, \
    attribute_modifiers=[ \
        {type:"attack_damage",slot:"mainhand",id:"sgp.damage",amount:6.0,operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc", color:white, italic:false, bold:true}, \
    enchantment_glint_override=false, \
    enchantments={"sgp.kits:kd_projectile_scaling":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with iron_helmet[ \
    custom_name={text:"Casque en Fer", color:white, italic:false, bold:true}, \
    trim={ \
        pattern:"spire", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with iron_chestplate[ \
    custom_name={text:"Plastron en Fer", color:white, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false} \
        ], \
    enchantments={protection:1, projectile_protection:2}, \
    trim={ \
        pattern:"coast", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with iron_leggings[ \
    enchantments={projectile_protection:2}, \
    custom_name={text:"Jambières en Fer", color:white, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------------", color:"#C0C0C0", italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false} \
        ], \
    trim={ \
        pattern:"spire", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with iron_boots[\
    lore=[ \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false}, \
        [ \
            {text:"» ", color:yellow, italic:false}, \
            {text:"Vous êtes ", color:white}, \
            {text:"plus", color:gold} \
            ], \
        [ \
            {text:"rapide ", color:gold, italic:false}, \
            {text:"dans l'", color:white}, \
            {text:"eau", color:"#55D5F0"} \
            ], \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false} \
        ], \
    custom_name={text:"Bottes en Fer", color:white, italic:false, bold:true}, \
    enchantments={"sgp.kits:depth_strider_boosted":2}, \
    trim={ \
        pattern:"eye", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.7 with arrow 16


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name={text:"Steak", color:white, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name={text:"Pomme d'or", color:white, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ] \
    ] 2