#> sgp.kits:collection/achimiste/on_kill
# 
# Gives the Alchimiste kill rewards

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic {\
    give: 'splash_potion[custom_name=\'{"bold":true,"color":"light_purple","italic":false,"text":"Potion de Soin"}\',lore=[\'{"color":"gray","italic":false,"text":"Régénère jusqu\'à 2","extra":[{"color":"red","text":"❤"}," instantanément"]}\'],potion_contents={potion:"minecraft:healing"},hide_additional_tooltip={},max_stack_size=64] 2', \
    give_2: 'splash_potion[custom_name=\'{"bold":true,"color":"light_purple","italic":false,"text":"Potion de Dégats"}\',lore=[\'{"color":"gray","italic":false,"text":"Inflige jusqu\'à 3","extra":[{"color":"red","text":"❤"}," instantanément"]}\'],potion_contents={potion:"minecraft:harming"},hide_additional_tooltip={},max_stack_size=64] 3', \
    actionbar:' \
        {"text":"+ 2 ❤ Potions de Soin ", "color":"red", "bold":true}, \
        {"text":"et 3 ⚔ Potions de Dégats !", "color":"dark_red"} ', \
    nb:1 }

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"splash_potion[ \
        custom_name='{\"text\":\"Potion de Cécité\", \"color\":\"light_purple\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"👁 Cécité (0:05)\", \"color\":\"#8B8589\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"blindness\", amplifier:0, duration:100} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 2 ❤ Potions de Soin, \", \"color\":\"red\", \"bold\":true}, \
        {\"text\":\"3 ⚔ Potions de Dégats \", \"color\":\"dark_red\"}, \
        {\"text\":\"et 1 👁 Potion de Cécité !\", \"color\":\"#8B8589\"} \
        ", \
    }