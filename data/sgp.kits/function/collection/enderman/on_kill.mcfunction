#> sgp.kits:collection/Enderman/on_kill
# 
# Gives the Enderman kill rewards

execute as @a[tag=sgp.enderman,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:" ender_pearl[ \
        custom_name='{\"text\":\"Yeux\", \"color\":\"dark_purple\", \"italic\":false, \"bold\":true}' \
        ] 2", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 2 Ⓞ Yeux !\", \"color\":\"dark_purple\", \"bold\":true}" \
    }

execute as @a[tag=sgp.enderman,scores={sgp.kills_give_2=3..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"splash_potion[ \
        custom_name='{\"text\":\"Potion de Rapidité\", \"color\":\"dark_purple\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"➠ Rapidité II (0:22)\", \"color\":\"aqua\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"speed\", amplifier:1, duration:440} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 2 Ⓞ Yeux \", \"color\":\"dark_purple\", \"bold\":true}, \
        {\"text\":\"et 1 Potion de ➠ Rapidité !\", \"color\":\"aqua\"} \
        " \
    }