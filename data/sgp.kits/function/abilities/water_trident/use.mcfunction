#> sgp.kits:abilities/water_trident/use

advancement revoke @s only sgp.kits:water_trident

execute at @s align xyz positioned ~ ~1 ~ \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        if block ~ ~ ~ #minecraft:air \
            unless entity @e[tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0,type=marker] \
                run function sgp.kits:abilities/water_trident/place_water

execute at @s anchored eyes positioned ^ ^ ^1 align xyz \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        if block ~ ~ ~ #minecraft:air \
            unless entity @e[tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0,type=marker] \
                run function sgp.kits:abilities/water_trident/place_water