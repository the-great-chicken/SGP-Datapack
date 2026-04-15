#> sgp.majeurs:pco/kit
# `{color, color_material, color_hex}`
#
# Equip a player with a custom kit for the "Poule-Canard-Oie" game, including
# a feather weapon, bread for healing, and colored leather armor.

clear @s
effect clear @s

# ---------- WEAPON ----------
$item replace entity @s hotbar.0 with feather[ \
    custom_name={text:"Plume", color:"$(color)", italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant I", color:dark_red, italic:false}, \
        {text:"4 dégâts", color:blue, italic:false} \
        ], \
    enchantments={unbreaking:0, sharpness:1} \
    tooltip_display={hidden_components:["attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
$item replace entity @s armor.head with leather_helmet[ \
    custom_name={text:"Tête", color:"$(color)", italic:false, bold:true}, \
    enchantments={binding_curse:1}, \
    dyed_color=$(color_hex), \
    trim={ \
        pattern:"sentry", \
        material:"$(color_material)" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

$item replace entity @s armor.chest with leather_chestplate[ \
    custom_name={text:"Corps", color:"$(color)", italic:false, bold:true}, \
    enchantments={binding_curse:1}, \
    dyed_color=$(color_hex), \
    trim={ \
        pattern:"snout", \
        material:"quartz" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

$item replace entity @s armor.legs with leather_leggings[ \
    custom_name={text:"Cuisses", color:"$(color)", italic:false, bold:true}, \
    enchantments={binding_curse:1}, \
    dyed_color=$(color_hex), \
    trim={ \
        pattern:"coast", \
        material:"quartz" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

$item replace entity @s armor.feet with leather_boots[ \
    custom_name={text:"Pattes", color:"$(color)", italic:false, bold:true}, \
    enchantments={binding_curse:1}, \
    dyed_color=$(color_hex), \
    trim={ \
        pattern:"wild", \
        material:gold, \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]


# ---------- FOOD ----------
$item replace entity @s weapon.offhand with bread[ \
    custom_name={text:"Miettes", color:"$(color)", italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 3", color:gray, italic:false}, \
            {text:"❤", color:red, italic:false} \
            ] \
        ] \
    ] 64

scoreboard players set @s sgp.reset_tags 1