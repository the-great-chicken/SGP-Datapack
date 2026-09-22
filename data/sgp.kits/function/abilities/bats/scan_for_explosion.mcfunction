#> sgp.kits:abilities/bats/scan_for_explosion
#
# Scan only grenade bats whose own one-second arming delay has elapsed.

execute store result score #bat_now sgp.dummy run time query gametime
execute as @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,type=bat] at @s \
    if score @s sgp.bat_arm_at <= #bat_now sgp.dummy \
    if function sgp.kits:abilities/bats/has_explosion_target \
        run function sgp.kits:abilities/bats/explode
