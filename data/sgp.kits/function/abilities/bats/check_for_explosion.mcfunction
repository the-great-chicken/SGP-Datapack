#> sgp.kits:abilities/bats/check_for_explosion

execute as @e[tag=sgp.bat_grenade,type=bat] at @s \
    if entity @a[tag=sgp.in_game, tag=!sgp.cancer, tag=!sgp.peaceful, distance=..2.5] \
        run function sgp.kits:abilities/bats/explode

execute if entity @e[tag=sgp.bat_grenade,type=bat] run schedule function sgp.kits:abilities/bats/check_for_explosion 8t
