#> sgp.kits:collection/poseidon/on_kill
# 
# Gives the Poséidon kill rewards

execute as @a[tag=sgp.poseidon,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'trident[ \
        custom_name={text:"Trident", color:dark_aqua, italic:false, bold:true}, \
        lore=[ \
            {text:"---------", color:"#C0C0C0", italic:false}, \
            {text:"8,5 dégâts", color:blue, italic:false} \
            ], \
        enchantments={"sgp.kits:kd_projectile_scaling":1, "sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        attribute_modifiers=[ \
            {type:"attack_damage", slot:"mainhand", id:"sgp:damage", amount:7.5, operation:"add_value"} \
            ], \
        unbreakable={}, \
        tooltip_display={hidden_components:["unbreakable","attribute_modifiers","enchantments"]} \
        ] 2', \
    give_2:air, \
    actionbar:{text:"+ 2 🔱 Tridents !", color:dark_aqua, bold:true} \
    }

execute as @a[tag=sgp.poseidon,scores={sgp.kills_give_2=5..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:'enchanted_golden_apple[ \
        custom_name={text:"Pomme d\'or Enchantée", color:light_purple, italic:false, bold:true}, \
        lore=[ \
             [ \
                {text:"Régénère ", color:gray, italic:false}, \
                {text:"entièrement", color:red, italic:false}, \
                {text:" + 6", color:gray, italic:false}, \
                {text:"❤", color:yellow, italic:false} \
                ], \
             [ \
                {text:"Donne aussi ", color:gray, italic:false}, \
                {text:"🔥 Résistance", color:"#D0853A", italic:false} \
                ] \
            ] \
        ]', \
    give_2:air, \
    actionbar:' \
        {text:"+ 2 🔱 Tridents ", color:dark_aqua, bold:true}, \
        {text:" et 1 ❤ Pomme d\\\'or Enchantée !", color:light_purple} \
        ' \
    }