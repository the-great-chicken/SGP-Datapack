#> sgp.kits:collection/archer/items
# 
# Gives the items of the Archer kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with wooden_sword[\
    custom_name={text:"Épée d'Entraînement", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------------", color:"#C0C0C0", italic:false}, \
        {text:"5 dégâts", color:blue, italic:false} \
        ], \
    attribute_modifiers=[\
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:4.0, operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc d'Élite", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------", color:"#C0C0C0", italic:false}, \
        {text:"🏹 Puissance III", color:dark_red, italic:false}, \
        {text:"⬱ Recul I", color:"#6F4E37", italic:false}, \
        {text:"∞ Infinité", color:"#E5E4E2", italic:false} \
        ], \
    enchantments={infinity:1, power:3, punch:1, "sgp.kits:splash_arrow":1, "sgp.kits:kd_projectile_scaling":1}, \
    piercing_weapon={"deals_knockback":false}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with leather_helmet[ \
    custom_name={text:"Chapeau en Cuir", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}], \
    enchantments={protection:1, "sgp.kits:repulsion":1}, \
    dyed_color=9633536, \
    trim={ \
        pattern:"coast", \
        material:"quartz" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

item replace entity @s armor.chest with chainmail_chestplate[ \
    custom_name={text:"Cotte de Mailles", color:green, italic:false, bold:true}, \
    enchantments={"sgp.kits:repulsion":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers"]} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name={text:"Pantalon en Cuir", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false} \
        ], \
    enchantments={protection:1, "sgp.kits:repulsion":1}, \
    dyed_color=9633536, \
    trim={ \
        pattern:"spire", \
        material:"quartz" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name={text:"Bottes en Cuir", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"---------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection I", color:dark_aqua, italic:false}, \
        {text:""}, \
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
    enchantments={protection:1, "sgp.kits:depth_strider_boosted":2, "sgp.kits:repulsion":1}, \
    dyed_color=9633536, \
    trim={ \
        pattern:"spire", \
        material:"quartz" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim","dyed_color"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.4 with arrow

item replace entity @s hotbar.5 with tipped_arrow[ \
    custom_name={text:"Flèche de Lenteur", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"⬳ Lenteur II (1:28)", color:"#555555", italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:1, duration:1760} \
            ] \
        }, \
    potion_duration_scale=1.0, \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    ] 2

item replace entity @s weapon.offhand with tipped_arrow[ \
    custom_name={text:"Flèche de Poison", color:green, italic:false, bold:true}, \
    lore=[ \
        {text:"☠ Poison (0:11)", color:"#55741B", italic:false} \
        ], \
    potion_contents="long_poison", \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    ] 5


# ---------- FOOD ----------
item replace entity @s hotbar.3 with cooked_beef[ \
    custom_name={text:"Steak", color:green, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name={text:"Pomme d'or", color:green, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ] \
    ] 3