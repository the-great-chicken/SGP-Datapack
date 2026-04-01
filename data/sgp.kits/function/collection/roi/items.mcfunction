#> sgp.kits:collection/roi/items
# 
# Gives the items of the Roi kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with golden_sword[ \
    custom_name={text:"Épée Royale", color:yellow, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant VII", color:dark_red, italic:false}, \
        {text:"8 dégats", color:blue, italic:false} \
        ], \
    enchantments={sharpness:7}, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp.damage", amount:4.0, operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc Royal", color:yellow, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"🏹 Puissance II", color:dark_red, italic:false} \
        ], \
    enchantments={power:2}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

# ---------- ARMOR ----------
item replace entity @s armor.head with golden_helmet[ \
    enchantments={protection:1, projectile_protection:2}, \
    custom_name={text:"Couronne", color:yellow, italic:false, bold:true}, \
    lore=[ \
        {text:"------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false} \
        ], \
    trim={ \
        pattern:"ward", \
        material:"redstone" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with golden_chestplate[ \
    custom_name={text:"Cuirasse Cérémoniale", color:yellow, italic:false, bold:true}, \
    trim={ \
        pattern:"wild", \
        material:"diamond" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with golden_leggings[ \
    custom_name={text:"Jambières Cérémoniales", color:yellow, italic:false, bold:true}, \
    trim={ \
        pattern:"eye", \
        material:"diamond" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with golden_boots[ \
    custom_name={text:"Bottes Cérémoniales", color:yellow, italic:false, bold:true}, \
    lore=[ \
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
    enchantments={"sgp.kits:depth_strider_boosted":1}, \
    trim={ \
        pattern:"dune", \
        material:"diamond" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.7 with arrow 12


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name={text:"Steak", color:yellow, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name={text:"Pomme d'or", color:yellow, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ] \
    ] 4