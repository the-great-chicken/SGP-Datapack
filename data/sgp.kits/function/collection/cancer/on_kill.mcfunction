#> sgp.kits:collection/cancer/on_kill
# 
# Gives the Cancer kill rewards

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"tipped_arrow[ \
        custom_name='{\"text\":\"Flèche de Lévitation\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"--------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"⟰ Lévitation IV (0:13)\", \"color\":\"#F2F3F4\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"levitation\", amplifier:3, duration:256} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    give_2:"tipped_arrow[ \
        custom_name='{\"text\":\"Flèche de Lenteur\", \"color\":\"dark_red\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"⬳ Lenteur IV (0:26)\", \"color\":\"#555555\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"slowness\", amplifier:3, duration:512} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    actionbar:" \
        {\"text\":\"+ 1 ⟰ Flèche de Lévitation \", \"color\":\"#F2F3F4\", \"bold\":true}, \
        {\"text\":\"et 1 ⬳ Flèche de Lenteur !\", \"color\":\"#555555\"} \
        " \
    }

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run function sgp.kits:collection/cancer/kills_give_2