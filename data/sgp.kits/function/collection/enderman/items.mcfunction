#> sgp.kits:collection/enderman/items
# 
# Gives the items of the Enderman kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with diamond_sword[ \
    custom_name={text:"Épée en 'Diamant'", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"------------------", color:"#C0C0C0", italic:false}, \
        {text:"❊ Affilage III", color:"#ADDBD9", italic:false}, \
        {text:"7 dégâts", color:blue, italic:false} \
        ], \
    enchantments={sweeping_edge:3}, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:6.0, operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

# ---------- ARMOR ----------
item replace entity @s armor.head with player_head[ \
    custom_name={text:"Tête", color:dark_purple, italic:false, bold:true}, \
    profile="WelcomeToMoes48", \
    enchantments={binding_curse:1, "sgp.kits:water_damage":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","profile"]} \
    ]

item replace entity @s armor.chest with leather_chestplate[ \
    custom_name={text:"Corps", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection III", color:dark_aqua, italic:false}, \
        {text:"➹ Protection I", color:dark_blue, italic:false} \
        ], \
    enchantments={protection:3, projectile_protection:1}, \
    dyed_color=0, \
    trim={ \
        pattern:"eye", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name={text:"Jambes", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection III", color:dark_aqua, italic:false}, \
        {text:"➹ Protection I", color:dark_blue, italic:false} \
        ], \
    enchantments={protection:3, projectile_protection:1}, \
    dyed_color=0, \
    trim={ \
        pattern:"dune", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name={text:"Pieds", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection III", color:dark_aqua, italic:false}, \
        {text:"➹ Protection I", color:dark_blue, italic:false}, \
        {text:""}, \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:dark_purple, italic:false}, \
        [ \
            {text:"⚠ ", color:dark_red, italic:false}, \
            {text:"Vous prenez des", color:red} \
            ], \
        [ \
            {text:"dégâts ", color:dark_red, italic:false}, \
            {text:"dans l'", color:red}, \
            {text:"eau ", color:"#55D5F0"}, \
            {text:"!", color:red} \
            ], \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:dark_purple, italic:false} \
        ], \
    enchantments={protection:3, projectile_protection:1}, \
    dyed_color=0, \
    trim={ \
        pattern:"raiser", \
        material:"amethyst" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.2 with splash_potion[ \
    custom_name={text:"Potion de Rapidité", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        {text:"➠ Rapidité II (0:22)", color:aqua, italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"speed", amplifier:1, duration:440} \
            ] \
        }, \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    max_stack_size=64 \
    ]

item replace entity @s hotbar.1 with ender_pearl[ \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    custom_name={text:"Yeux", color:dark_purple, italic:false, bold:true} \
    ] 8


# ---------- FOOD ----------
item replace entity @s weapon.offhand with chorus_fruit[ \
    custom_name={text:"Chorus", color:dark_purple, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 2", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 64