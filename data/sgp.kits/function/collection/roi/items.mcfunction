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
    enchantments={ \
        levels: {sharpness:7}, \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"attack_damage", slot:"mainhand", id:"sgp.damage", amount:4.0, operation:"add_value"}, \
            ], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc Royal", color:yellow, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"🏹 Puissance II", color:dark_red, italic:false} \
        ], \
    enchantments={ \
        levels: {power:2}, \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

# ---------- ARMOR ----------
item replace entity @s armor.head with golden_helmet[ \
    enchantments={ \
        levels: {protection:1, projectile_protection:2}, \
        show_in_tooltip:false \
        }, \
    custom_name={text:"Couronne", color:yellow, italic:false, bold:true}, \
    lore=[ \
        {text:"------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false} \
        ], \
    trim={ \
        pattern:"ward", \
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
    custom_name={text:"Cuirasse Cérémoniale", color:yellow, italic:false, bold:true}, \
    trim={ \
        pattern:"wild", \
        material:"diamond", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
    ]

item replace entity @s armor.legs with golden_leggings[ \
    custom_name={text:"Jambières Cérémoniales", color:yellow, italic:false, bold:true}, \
    trim={ \
        pattern:"eye", \
        material:"diamond", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
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
    enchantments={ \
        levels: {"sgp.kits:depth_strider_boosted":1}, \
        show_in_tooltip:false \
    }, \
    trim={ \
        pattern:"dune", \
        material:"diamond", \
        show_in_tooltip:false \
        }, \
    attribute_modifiers={ \
        modifiers: [], \
        show_in_tooltip:false \
        }, \
    unbreakable={show_in_tooltip:false} \
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