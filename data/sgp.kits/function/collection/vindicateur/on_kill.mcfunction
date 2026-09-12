#> sgp.kits:collection/vindicateur/on_kill
# 
# Gives the Vindicateur kill rewards

execute if score @s sgp.kills_give_1 matches 3.. run function sgp.kits:kills_give/basic { \
    nb:1, threshold:3, \
    give:'splash_potion[ \
        custom_name={text:"Potion de Faiblesse", color:dark_green, italic:false, bold:true}, \
        lore=[ \
            {text:"⬊ Faiblesse I (0:05)", color:"#777075", italic:false} \
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={ \
            custom_effects: [ \
                {id:"weakness", amplifier:0, duration:100} \
                ] \
            }, \
        tooltip_display={hidden_components:["potion_contents","enchantments"]}, \
        max_stack_size=64 \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 ⬊ Potion de Faiblesse !", color:"#777075", bold:true}, \
    width:319, \
    }

execute if score @s sgp.kills_give_2 matches 5.. run function sgp.kits:kills_give/basic { \
    nb:2, threshold:5, \
    give:'totem_of_undying[ \
        enchantments={protection:1}, \
        custom_name={text:"Totem", color:gold, italic:false, bold:true}, \
        tooltip_display={hidden_components:["enchantments"]}, \
        ]', \
    give_2:air, \
    actionbar:{text:"+ 1 ⚚ Totem !", color:gold, bold:true}, \
    width:157, \
    }

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 3.. run return run function sgp.kits:collection/vindicateur/on_kill
execute if score @s sgp.kills_give_2 matches 5.. run return run function sgp.kits:collection/vindicateur/on_kill
