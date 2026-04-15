#> sgp.kits:collection/pigeon/items
# 
# Gives the items of the Pigeon kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with feather[ \
    custom_name={text:"Plume", color:dark_gray, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant V", color:dark_red, italic:false}, \
        {text:"⬱ Recul III", color:"#6F4E37", italic:false}, \
        {text:"4 dégats", color:blue, italic:false} \
        ], \
    enchantments={knockback:3, sharpness:5}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Lance Plumes", color:dark_gray, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"🏹 Puissance II", color:dark_red, italic:false}, \
        {text:"∞ Infinité", color:"#E5E4E2", italic:false} \
        ], \
    enchantments={power:2, infinity:1, "sgp.kits:kd_projectile_scaling":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with player_head[ \
    custom_name={text:"Tête", color:dark_gray, italic:false, bold:true}, \
    profile="__pif__", \
    enchantments={binding_curse:1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s armor.chest with elytra[ \
    custom_name={text:"Ailes", color:dark_gray, italic:false, bold:true}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s armor.legs with chainmail_leggings[ \
    custom_name={text:"Cuisses", color:dark_gray, italic:false, bold:true}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with chainmail_boots[ \
    custom_name={text:"Pattes", color:dark_gray, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection II", color:dark_aqua, italic:false}, \
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
    enchantments={protection:2, "sgp.kits:depth_strider_boosted":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s inventory.8 with arrow[ \
    custom_name={text:"uwu", italic:false} \
    ]

item replace entity @s hotbar.2 with firework_rocket[ \
    custom_name={text:"Boost", color:dark_gray, italic:false, bold:true}, \
    tooltip_display= {hidden_components:["fireworks"]}, \
    ] 5


# ---------- FOOD ----------
item replace entity @s weapon.offhand with bread[ \
    custom_name={text:"Miettes", color:dark_gray, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 3", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 64