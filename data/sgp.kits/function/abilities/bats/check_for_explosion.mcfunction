
#> sgp.kits:abilities/bats/check_for_explosion

execute as @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,type=bat] at @s \
    if function sgp.kits:abilities/bats/has_explosion_target \
        run function sgp.kits:abilities/bats/explode

# Spent bats may survive until vanilla processes their fuse-0 TNT. They no
# longer keep the scan loop alive and cannot be detonated by another callback.
execute if entity @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,type=bat] run schedule function sgp.kits:abilities/bats/check_for_explosion 8t
