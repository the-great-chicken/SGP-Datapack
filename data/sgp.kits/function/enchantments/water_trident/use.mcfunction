advancement revoke @s only sgp.kits:water_trident

execute at @s align xyz positioned ~ ~1 ~ \
    if block ~ ~ ~ #minecraft:air \
        unless entity @e[type=marker,tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0] \
            run function sgp.kits:enchantments/water_trident/place_water

execute at @s anchored eyes positioned ^ ^ ^1 align xyz \
    if block ~ ~ ~ #minecraft:air \
        unless entity @e[type=marker,tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0] \
            run function sgp.kits:enchantments/water_trident/place_water