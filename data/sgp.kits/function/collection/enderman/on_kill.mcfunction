#> sgp.kits:collection/enderman/on_kill
# 
# Gives the Enderman kill rewards

execute if score @s sgp.kills_give_1 matches 1.. run function sgp.kits:kills_give/basic { \
    nb:1, threshold:1, \
    give:'ender_pearl[ \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        custom_name={text:"Yeux", color:dark_purple, italic:false, bold:true}, \
        tooltip_display={hidden_components:["enchantments"]} \
        ] 2', \
    give_2:air, \
    actionbar:{text:"+ 2 Ⓞ Yeux !", color:dark_purple, bold:true}, \
    width:152, \
    }

execute if score @s sgp.kills_give_2 matches 3.. run function sgp.kits:kills_give/basic { \
    nb:2, threshold:3, \
    give:'splash_potion[ \
        custom_name={text:"Potion de Rapidité", color:dark_purple, italic:false, bold:true}, \
        lore=[ \
            {text:"➠ Rapidité II (0:22)", color:aqua, italic:false} \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"speed", amplifier:1, duration:440} \
                ] \
            }, \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        tooltip_display= {hidden_components:["potion_contents","enchantments"]}, \
        max_stack_size=64 \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 ➠ Potion de Rapidité !", color:aqua, bold:true}, \
    width:303, \
    }

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 1.. run return run function sgp.kits:collection/enderman/on_kill
execute if score @s sgp.kills_give_2 matches 3.. run return run function sgp.kits:collection/enderman/on_kill
