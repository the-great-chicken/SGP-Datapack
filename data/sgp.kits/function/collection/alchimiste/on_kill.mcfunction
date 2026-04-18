#> sgp.kits:collection/achimiste/on_kill
# 
# Gives the Alchimiste kill rewards

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic {\
    give: 'splash_potion[ \
        custom_name={text:"Potion de Soin", color:light_purple, italic:false, bold:true}, \
        lore=[ \
            {text:"Régénère jusqu\'à 2", color:gray, italic:false, extra:[{text:"❤", color:red}, " instantanément"]}\
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={potion:"minecraft:healing"}, \
        tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
        max_stack_size=64] \
        2', \
    give_2: 'splash_potion[ \
        custom_name={text:"Potion de Dégâts", color:light_purple, italic:false, bold:true}, \
        lore=[ \
            {text:"Inflige jusqu\'à 3", color:gray, italic:false, extra:[{text:"❤", color:red}, " instantanément"]} \
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={potion:"minecraft:harming"}, \
        tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
        max_stack_size=64 \
        ] 3\
        ', \
    actionbar:' \
        {text:"+ 2 ❤ Potions de Soin ", color:red, bold:true}, \
        {text:"et 3 ⚔ Potions de Dégâts !", color:dark_red} ', \
    nb:1 }

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:'splash_potion[ \
        custom_name={text:"Potion de Cécité", color:light_purple, italic:false, bold:true}, \
        lore=[ \
            {text:"👁 Cécité (0:05)", color:"#8B8589", italic:false} \
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={ \
            custom_effects: [ \
                {id:"blindness", amplifier:0, duration:100} \
                ] \
            }, \
        tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
        max_stack_size=64 \
        ]', \
    give_2:air, \
    actionbar:' \
        {text:"+ 2 ❤ Potions de Soin, ", color:red, bold:true}, \
        {text:"3 ⚔ Potions de Dégâts ", color:dark_red}, \
        {text:"et 1 👁 Potion de Cécité !", color:"#8B8589"} \
        ', \
    }