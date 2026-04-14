#> sgp.kits:abilities/bats/check_for_explosion

execute as @e[tag=sgp.bat_grenade,type=bat] at @s \
    if entity @a[tag=sgp.in_game, tag=!sgp.cancer, tag=!sgp.peaceful, distance=..2.5] \
        run summon tnt ~ ~ ~ {explosion_power:1.3f,fuse:0s,Tags:["sgp.bat_grenade"]}

execute if entity @e[tag=sgp.bat_grenade,type=bat] run schedule function sgp.kits:abilities/bats/check_for_explosion 8t