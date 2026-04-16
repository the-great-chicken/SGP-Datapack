#> sgp.kits:collection/poseidon/items
# 
# Gives the items of the Poseidon kit to the player

# ---------- WEAPONS ----------
give @s trident[ \
    custom_name={text:"Le Trident", color:dark_aqua, italic:false, bold:true}, \
    lore=[ \
        {text:"-----------", color:"#C0C0C0", italic:false}, \
        {text:"⚡ Impulsion I", color:yellow, italic:false}, \
        {text:"8,5 dégâts", color:blue, italic:false} \
        ], \
    enchantment_glint_override=true, \
    enchantments={riptide:1}, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:7.5, operation:"add_value"}, \
        ], \
    custom_data={sgp.water_trident:true}, \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ]

give @s trident[ \
    custom_name={text:"Trident", color:dark_aqua, italic:false, bold:true}, \
    lore=[ \
        {text:"---------", color:"#C0C0C0", italic:false}, \
        {text:"8,5 dégâts", color:blue, italic:false} \
        ], \
    enchantments={"sgp.kits:kd_projectile_scaling":1}, \
    enchantment_glint_override=false, \
    attribute_modifiers=[ \
        {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:7.5, operation:"add_value"}, \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
    ] 17


# ---------- ARMOR ----------
item replace entity @s armor.feet with chainmail_boots[ \
    custom_name={text:"Palmes", color:dark_aqua, italic:false, bold:true}, \
    lore=[ \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false}, \
        [ \
            {text:"⚡ ", color:yellow, italic:false}, \
            {text:"Vous êtes ", color:white}, \
            {text:"très"} \
            ], \
        [ \
            {text:"rapide ", color:yellow, italic:false}, \
            {text:"dans l'", color:white}, \
            {text:"eau ", color:"#55D5F0"}, \
            {text:"!", color:white} \
            ], \
        {text:"≈≈≈≈≈≈≈≈≈≈≈≈≈≈", color:"#4040EA", italic:false} \
        ], \
    enchantments={"sgp.kits:depth_strider_boosted":25}, \
    attribute_modifiers=[ \
        {type:"armor", amount:-1, id:"armor", operation:"add_multiplied_total", slot:armor} \
        ], \
    unbreakable={}, \
    tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments","trim"]} \
    ]


# ---------- FOOD ----------
item replace entity @s hotbar.1 with cooked_cod[ \
    custom_name={text:"Morue", color:dark_aqua, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 2,5", color:gray, italic:false}, \
            {text:"❤", color:red} \
            ] \
        ] \
    ] 64