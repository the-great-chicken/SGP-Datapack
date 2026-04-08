execute as @e[type=bat, tag=sgp.bat_grenade] at @s \
    if entity @a[tag=sgp.in_game, tag=!sgp.cancer, tag=!sgp.peaceful, distance=..3] \
        run function sgp.kits:abilities/bats/explode

schedule function sgp.kits:abilities/bats/check_for_explosion 10t