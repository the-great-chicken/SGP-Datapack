#> sgp.kits:collection/achimiste/on_kill
# 
# Gives the Alchimiste kill rewards

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_1=1..}] run function sgp.kits:collection/alchimiste/kills_give_1

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