#> sgp.kits:collection/pyromane/items
# 
# Gives the items of the Pyromane kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with blaze_rod[ \
    custom_name={text:"Bâton Brûlant", color:gold, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant IX", color:dark_red, italic:false}, \
        {text:"🔥 Flamme I", color:"#FF8C00", italic:false}, \
        {text:"⬱ Recul I", color:"#6F4E37", italic:false}, \
        {text:"6 dégats", color:blue, italic:false} \
        ], \
    enchantments={sharpness:9, knockback:1, fire_aspect:1}, \
    tooltip_display={hidden_components:["attribute_modifiers","enchantments"]} \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc Brûlant", color:gold, italic:false, bold:true}, \
    lore=[ \
        {text:"------------", color:"#C0C0C0", italic:false}, \
        {text:"🔥 Flamme", color:"#FF8C00", italic:false} \
        ], \
    enchantments={flame:1, "sgp.kits:kd_projectile_scaling":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with iron_helmet[ \
    custom_name={text:"Casque en Fer", color:gold, italic:false, bold:true}, \
    trim={ \
        pattern:"wild", \
        material:gold, \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with iron_chestplate[ \
    custom_name={text:"Plastron en Fer", color:gold, italic:false, bold:true}, \
    trim={ \
        pattern:"snout", \
        material:gold, \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with diamond_leggings[ \
    custom_name={text:"Jambières Ignifuges", color:gold, italic:false, bold:true}, \
    lore=[ \
        {text:"--------------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection II", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false}, \
        {text:"🔥 Protection VI", color:gold, italic:false}, \
        {text:"☀ Protection V", color:red, italic:false}, \
        {text:"᠅ Épines II", color:dark_green, italic:false} \
        ], \
    enchantments={protection:2, thorns:2, fire_protection:6, blast_protection:5, projectile_protection:2}, \
    trim={ \
        pattern:"silence", \
        material:gold, \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with iron_boots[ \
    custom_name={text:"Bottes en Fer", color:gold, italic:false, bold:true}, \
    lore=[ \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈", color:yellow, italic:false}, \
        [ \
            {text:"× ", color:red, italic:false}, \
            {text:"Vous êtes ", color:white}, \
            {text:"lent", color:red} \
            ], \
        [ \
            {text:"dans l'", color:white, italic:false}, \
            {text:"eau", color:"#55D5F0"} \
            ], \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈", color:yellow, italic:false} \
        ], \
    trim={ \
        pattern:"wayfinder", \
        material:gold, \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.7 with arrow 8

item replace entity @s weapon.offhand with flint_and_steel[ \
    custom_name={text:"Briquet", color:gold, italic:false, bold:true}, \
    unbreakable={} \
    ]

item replace entity @s hotbar.4 with strider_spawn_egg[ \
    entity_data={ \
        id:"minecraft:firework_rocket", \
        LifeTime:0, \
        FireworksItem:{id:"firework_rocket",count:1,components:{fireworks:{explosions: [ \
            {shape:"large_ball", colors: [11743532,15435844], fade_colors: [14602026,15435844], has_twinkle:true}, \
            {shape:"large_ball", colors: [11743532,15435844], fade_colors: [14602026,15435844], has_twinkle:true} \
            ], \
        }}} \
        }, \
    custom_name={text:"Explosifs", color:red, italic:false, bold:true} \
    ] 8


# ---------- FOOD ----------
item replace entity @s hotbar.3 with cooked_beef[ \
    custom_name={text:"Steak", color:gold, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name={text:"Pomme d'or", color:gold, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ] \
    ] 2