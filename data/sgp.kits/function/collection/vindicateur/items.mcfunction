#> sgp.kits:collection/vindicateur/items
# 
# Gives the items of the Vindicateur kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with iron_axe[ \
    custom_name={text:"Hache usée", color:dark_green, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------", color:"#C0C0C0", italic:false}, \
        {text:"7 dégats", color:blue, italic:false} \
        ], \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp.damage", amount:7, operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with iron_helmet[ \
    custom_name={text:"Casque en Fer", color:dark_green, italic:false, bold:true}, \
    trim={ \
        pattern:"rib", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with diamond_chestplate[ \
    custom_name={text:"Plastron en Diamant", color:dark_green, italic:false, bold:true}, \
    trim={ \
        pattern:"rib", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name={text:"Pantalon en Cuir", color:dark_green, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"᠅ Épines I", color:dark_green, italic:false} \
        ], \
    enchantments={thorns:1}, \
    dyed_color=9533531, \
    trim={ \
        pattern:"rib", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name={text:"Bottes en Cuir", color:dark_green, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"᠅ Épines III", color:dark_green, italic:false}, \
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
    enchantments={thorns:3, "sgp.kits:depth_strider_boosted":1}, \
    dyed_color=9533531, \
    trim={ \
        pattern:"rib", \
        material:"copper" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.2 with splash_potion[ \
    custom_name={text:"Potion de Faiblesse", color:dark_green, italic:false, bold:true}, \
    lore=[ \
        {text:"⬊ Faiblesse I (0:05)", color:"#777075", italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"weakness", amplifier:0, duration:100} \
            ] \
        }, \
    tooltip_display={hidden_components:["potion_contents"]}, \
    max_stack_size=64 \
    ]


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name={text:"Steak", color:dark_green, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 32