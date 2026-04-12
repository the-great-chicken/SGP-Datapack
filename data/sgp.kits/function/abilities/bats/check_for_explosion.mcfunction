execute as @e[type=bat, tag=sgp.bat_grenade] at @s \
    if entity @a[tag=sgp.in_game, tag=!sgp.cancer, tag=!sgp.peaceful, distance=..2.5] \
        run summon tnt ~ ~ ~ {explosion_power:1.4f,fuse:0s,Tags:["sgp.bat_grenade"]}

schedule function sgp.kits:abilities/bats/check_for_explosion 10t