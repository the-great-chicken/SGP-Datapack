#> sgp.kits:collection/cancer/items
# 
# Gives the items of the Cancer kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stick[ \
    custom_name={text:"Bâton Cancérigène", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"-------------------", color:"#C0C0C0", italic:false}, \
        {text:"⚔ Tranchant XII", color:dark_red, italic:false}, \
        {text:"⬱ Recul IV", color:"#6F4E37", italic:false}, \
        {text:"7,5 dégâts", color:blue, italic:false} \
        ], \
    enchantments={knockback:4}, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:6.5, operation:"add_value"} \
        ], \
    tooltip_display={hidden_components:["attribute_modifiers","enchantments"]}, \
    item_model="sgp.kits:cancer/stick" \
    ]

item replace entity @s hotbar.1 with bow[ \
    custom_name={text:"Arc Cancérigène", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------------", color:"#C0C0C0", italic:false}, \
        {text:"🔥 Flamme", color:"#FF8C00", italic:false}, \
        {text:"⬱ Recul IV", color:"#6F4E37", italic:false} \
        ], \
    enchantments={punch:4, flame:1, "sgp.kits:kd_projectile_scaling":1, "sgp.kits:perfect_accuracy":1}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]}, \
    item_model="sgp.kits:cancer/bow" \
    ]


# ---------- ARMOR ----------
item replace entity @s armor.head with leather_helmet[ \
    custom_name={text:"Chapeau en Cuir", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection II", color:dark_aqua, italic:false} \
        ], \
    enchantments={protection:2}, \
    trim={ \
        pattern:"vex", \
        material:"redstone" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.chest with golden_chestplate[ \
    custom_name={text:"Plastron en Or", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"---------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection II", color:dark_aqua, italic:false}, \
        {text:"➹ Protection II", color:dark_blue, italic:false}, \
        {text:"᠅ Épines III", color:dark_green, italic:false} \
        ], \
    enchantments={protection:2, thorns:3, projectile_protection:2}, \
    trim={ \
        pattern:"vex", \
        material:"redstone" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.legs with leather_leggings[ \
    custom_name={text:"Pantalon en Cuir", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"----------------", color:"#C0C0C0", italic:false}, \
        {text:"🛡 Protection II", color:dark_aqua, italic:false} \
        ], \
    enchantments={protection:2}, \
    trim={ \
        pattern:"tide", \
        material:"redstone" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]

item replace entity @s armor.feet with leather_boots[ \
    custom_name={text:"Bottes en Cuir", color:dark_red, italic:false, bold:true}, \
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
    trim={ \
        pattern:"spire", \
        material:"redstone" \
        }, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- MISC ----------
item replace entity @s hotbar.3 with tipped_arrow[ \
    custom_name={text:"Flèche de Lévitation", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"⟰ Lévitation IV (0:13)", color:"#F2F3F4", italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"levitation", amplifier:3, duration:256} \
            ] \
        }, \
    potion_duration_scale=1.0, \
    tooltip_display={hidden_components:["potion_contents"]}, \
    item_model="sgp.kits:cancer/levitation" \
    ] 5

item replace entity @s hotbar.4 with tipped_arrow[ \
    custom_name={text:"Flèche de Lenteur", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"⬳ Lenteur IV (0:26)", color:"#555555", italic:false} \
        ], \
    potion_contents={ \
        custom_effects: [ \
            {id:"slowness", amplifier:3, duration:512} \
            ] \
        }, \
    potion_duration_scale=1.0, \
    tooltip_display= {hidden_components:["potion_contents"]}, \
    item_model="sgp.kits:cancer/slowness" \
    ] 5

item replace entity @s hotbar.5 with splash_potion[ \
    custom_name={text:"Potion de Rapidité", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"➠ Rapidité II (0:15)", color:aqua, italic:false} \
        ], \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    potion_contents={ \
        custom_effects: [ \
            {id:"speed", amplifier:1, duration:300} \
            ] \
        }, \
    tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
    item_model="sgp.kits:cancer/speed", \
    max_stack_size=64 \
    ] 3


item replace entity @s hotbar.6 with splash_potion[ \
    custom_name={text:"Potion de Saut", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        {text:"⇪ Sauts améliorés III (0:30)", color:green, italic:false} \
        ], \
    enchantments={"sgp.kits:perfect_accuracy":1}, \
    enchantment_glint_override=false, \
    potion_contents={ \
        custom_effects: [ \
            {id:"jump_boost", amplifier:2, duration:600} \
            ] \
        }, \
    tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
    item_model="sgp.kits:cancer/jump", \
    max_stack_size=64 \
    ] 3


# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_beef[ \
    custom_name={text:"Steak", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ], \
    item_model="sgp.kits:cancer/beef" \
    ] 32

item replace entity @s hotbar.2 with golden_apple[ \
    custom_name={text:"Pomme d'or", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ], \
    item_model="sgp.kits:cancer/golden_apple" \
    ] 4