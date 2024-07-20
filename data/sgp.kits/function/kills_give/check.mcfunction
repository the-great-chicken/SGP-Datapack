#> sgp.kits:kills_give/check
# 
# Checks if a player made a kill, and if so, which kit they have.
#
# Runs the appropriate function to reward them for their kill.

# ---------- ALCHIMISTE ----------
execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/alchimiste_1

execute as @a[tag=sgp.alchimiste,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"splash_potion[ \
        custom_name='{\"text\":\"Potion de Cécité\", \"color\":\"light_purple\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"----------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
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


# ---------- ARCHER ----------
execute as @a[tag=sgp.archer,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"tipped_arrow[ \
        custom_name='{\"text\":\"Flèche de Poison\", \"color\":\"green\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"-----------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"☠ Poison (0:11)\", \"color\":\"#55741B\", \"italic\":false}' \
            ], \
        potion_contents=\"long_poison\", \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 1 ☠ Flèche de Poison !\", \"color\":\"#55741B\", \"bold\":true}" \
    }

execute as @a[tag=sgp.archer,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2,  \
    give:"tipped_arrow[ \
        custom_name='{\"text\":\"Flèche de Lenteur\", \"color\":\"green\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"⬳ Lenteur II (1:28)\", \"color\":\"#555555\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"slowness\", amplifier:1, duration:1760} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 1 ☠ Flèche de Poison \", \"color\":\"#55741B\", \"bold\":true}, \
        {\"text\":\"et 1 ⬳ Flèche de Lenteur !\", \"color\":\"#555555\"}" \
    }

execute as @a[tag=sgp.archer,scores={sgp.kills_give_3=3..}] run function sgp.kits:kills_give/basic { \
    nb:3, \
    give:"golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or\", \"color\":\"green\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" + 2\"}, \
                {\"text\":\"❤\", \"color\":\"yellow\"} \
                ]' \
            ] \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 1 ☠ Flèche de Poison \", \"color\":\"green\", \"bold\":true}, \
        {\"text\":\"et 1 ❤ Pomme d'or !\", \"color\":\"yellow\"} \
        " \
    }


# ---------- CANCER ----------
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

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/cancer_2


# ---------- COMBATTANT ----------
execute as @a[tag=sgp.combattant,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow 3", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 3 ➶ Flèches !\", \"color\":\"gray\", \"bold\":true}" \
    }

execute as @a[tag=sgp.combattant,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or\", \"color\":\"white\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" + 2\"}, \
                {\"text\":\"❤\", \"color\":\"yellow\"} \
                ]' \
            ] \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 3 ➶ Flèches \", \"color\":\"gray\", \"bold\":true}, \
        {\"text\":\"et 1 ❤ Pomme d\\'or !\", \"color\":\"yellow\"} \
        " \
    }


# ---------- ÉCLAIREUR ----------
execute as @a[tag=sgp.eclaireur,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow 2", \
    give_2:"golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or\", \"color\":\"aqua\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" + 2\"}, \
                {\"text\":\"❤\", \"color\":\"yellow\"} \
                ]' \
            ] \
        ] 2", \
    actionbar:" \
        {\"text\":\"+ 2 ➶ Flèches \", \"color\":\"gray\", \"bold\":true}, \
        {\"text\":\"et 2 ❤ Pommes d'or !\", \"color\":\"yellow\"} \
        " \
    }


# ---------- ENDERMAN ----------
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


# ---------- PIGEON ----------
execute as @a[tag=sgp.pigeon,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"firework_rocket[ \
        custom_name='{\"text\":\"Boost\", \"color\":\"dark_gray\", \"italic\":false, \"bold\":true}', \
        ] 2", \
    give_2:air, \
    actionbar:"{\"text\":\"+ ✦ 2 Boost !\", \"color\":\"dark_gray\", \"bold\":true}" \
    }


# ---------- POSÉIDON ----------
execute as @a[tag=sgp.poseidon,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"trident[ \
        custom_name='{\"text\":\"Trident\", \"color\":\"dark_aqua\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"---------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"7,5 dégats\", \"color\":\"blue\", \"italic\":false}' \
            ], \
        enchantments={ \
            levels: {impaling:4}, \
            show_in_tooltip:false \
            }, \
        attribute_modifiers={ \
            modifiers: [ \
                {type:\"generic.attack_damage\", slot:\"mainhand\", id:\"sgp.damage\", amount:7.5, operation:\"add_value\"}, \
                ], \
            show_in_tooltip:false \
            }, \
        unbreakable={show_in_tooltip:false} \
        ] 2", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 2 🔱 Tridents !\", \"color\":\"dark_aqua\", \"bold\":true}" \
    }

execute as @a[tag=sgp.poseidon,scores={sgp.kills_give_2=5..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"enchanted_golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or Enchantée\", \"color\":\"light_purple\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère \", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"entièrement\", \"color\":\"red\", \"italic\":false}, \
                {\"text\":\" + 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"yellow\", \"italic\":false} \
                ]', \
            '[ \
                {\"text\":\"Donne aussi \", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"🔥 Résistance\", \"color\":\"#D0853A\", \"italic\":false} \
                ]' \
            ] \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 2 🔱 Tridents \", \"color\":\"dark_aqua\", \"bold\":true}, \
        {\"text\":\" et 1 ❤ Pomme d'or Enchantée !\", \"color\":\"light_purple\"} \
        ", \
    }


# ---------- PYROMANE ----------
execute as @a[tag=sgp.pyromane,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"arrow", \
    give_2:"firework_rocket[ \
        custom_name='{\"text\":\"Explosifs\", \"color\":\"red\", \"italic\":false, \"bold\":true}', \
        fireworks={ \
            explosions: [ \
                {shape:\"large_ball\", colors: [I;11743532,15435844], fade_colors: [I;14602026,15435844], has_twinkle:true}, \
                {shape:\"large_ball\", colors: [I;11743532,15435844], fade_colors: [I;14602026,15435844], has_twinkle:true} \
                ], \
            flight_duration:-2 \
            } \
        ] 2", \
    actionbar:" \
        {\"text\":\"+ 1 ➶ Flèche \", \"color\":\"gray\", \"bold\":true}, \
        {\"text\":\"et 2 ☀ Explosifs !\", \"color\":\"red\"} \
        " \
    }

execute as @a[tag=sgp.pyromane,scores={sgp.kills_give_2=3..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or\", \"color\":\"gold\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" + 2\"}, \
                {\"text\":\"❤\", \"color\":\"yellow\"} \
                ]' \
            ] \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 1 ➶ Flèche, \",\"color\":\"gray\", \"bold\":true}, \
        {\"text\":\"2 ☀ Explosifs \", \"color\":\"red\"}, \
        {\"text\":\"et 1 ❤ Pomme d'or !\", \"color\":\"yellow\"} \
        ", \
    }


# ---------- ROI ----------
execute as @a[tag=sgp.roi,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/roi


# ---------- TANK ----------
execute as @a[tag=sgp.tank,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"golden_apple[ \
        custom_name='{\"text\":\"Pomme d\\'or\", \"color\":\"dark_blue\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '[ \
                {\"text\":\"Régénère jusqu\\'à 6\", \"color\":\"gray\", \"italic\":false}, \
                {\"text\":\"❤\", \"color\":\"red\"}, \
                {\"text\":\" + 2\"}, \
                {\"text\":\"❤\", \"color\":\"yellow\"} \
                ]' \
            ] \
        ]", \
    give_2:"tipped_arrow[ \
        custom_name='{\"text\":\"Flèche du Maitre Tortue\", \"color\":\"dark_blue\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"------------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"🛡 Résistance II (0:08)\", \"color\":\"#536878\", \"italic\":false}', \
            '{\"text\":\"⬳ Lenteur IV (0:08)\", \"color\":\"#555555\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"slowness\", amplifier:5, duration:160}, \
                {id:\"resistance\", amplifier:1, duration:160} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    actionbar:" \
        {\"text\":\"+ 1 ➶ Flèche \", \"color\":\"#545F67\", \"bold\":true}, \
        {\"text\":\"et 1 ❤ Pomme d'or !\", \"color\":\"yellow\"} \
        " \
    }

execute as @a[tag=sgp.tank,scores={sgp.kills_give_2=3..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"potion[ \
        custom_name='{\"text\":\"Potion du Maitre Tortue\", \"color\":\"dark_blue\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"------------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"🛡 Résistance IV (0:20)\", \"color\":\"#536878\", \"italic\":false}', \
            '{\"text\":\"⬳ Lenteur VI (0:20)\", \"color\":\"#555555\", \"italic\":false}' \
            ], \
        potion_contents=\"strong_turtle_master\", \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:" \
        {\"text\":\"+ 1 ➶ Flèche, \", \"color\":\"#545F67\", \"bold\":true}, \
        {\"text\":\"1 🧪 Potion \", \"color\":\"dark_blue\"}, \
        {\"text\":\"et 1 ❤ Pomme d'or !\", \"color\":\"yellow\"} \
        " \
    }


# ---------- VINDICATEUR ----------
execute as @a[tag=sgp.vindicateur,scores={sgp.kills_give_1=3..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:"splash_potion[ \
        custom_name='{\"text\":\"Potion de Faiblesse\", \"color\":\"dark_green\", \"italic\":false, \"bold\":true}', \
        lore=[ \
            '{\"text\":\"-------------------\", \"color\":\"#C0C0C0\", \"italic\":false}', \
            '{\"text\":\"⬊ Faiblesse I (0:05)\", \"color\":\"#777075\", \"italic\":false}' \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:\"weakness\", amplifier:0, duration:100} \
                ] \
            }, \
        hide_additional_tooltip={} \
        ]", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 1 ⬊ Potion de Faiblesse !\", \"color\":\"#777075\", \"bold\":true}" \
    }

execute as @a[tag=sgp.vindicateur,scores={sgp.kills_give_2=5..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give:"totem_of_undying[ \
        enchantments={ \
            levels: {protection:1}, \
            show_in_tooltip:false \
            }, \
        custom_name='{\"text\":\"Totem\", \"color\":\"gold\", \"italic\":false, \"bold\":true}' \
        ]", \
    give_2:air, \
    actionbar:"{\"text\":\"+ 1 ⚚ Totem !\", \"color\":\"gold\", \"bold\":true}" \
    }