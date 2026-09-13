#> sgp.kits:collection/pigeon/on_kill
# 
# Gives the Pigeon kill rewards

execute if score @s sgp.kills_give_1 matches 1.. run function sgp.kits:kills_give/basic { \
    nb:1, threshold:1, \
    give:'firework_rocket[ \
        custom_name={text:"Boost", color:dark_gray, italic:false, bold:true}, \
        tooltip_display={hidden_components:["fireworks"]}, \
        ] 2', \
    give_2:air, \
    actionbar:{text:"+ ✦ 2 Boost !", color:dark_gray, bold:true}, \
    width:157, \
    }

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 1.. run return run function sgp.kits:collection/pigeon/on_kill
