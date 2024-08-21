#> sgp.kits:collection/pigeon/on_kill
# 
# Gives the Pigeon kill rewards

execute as @a[tag=sgp.pigeon,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'firework_rocket[ \
        custom_name=\'{"text":"Boost", "color":"dark_gray", "italic":false, "bold":true}\', \
        hide_additional_tooltip={} \
        ] 2', \
    give_2:air, \
    actionbar:'{"text":"+ ✦ 2 Boost !", "color":"dark_gray", "bold":true}' \
    }