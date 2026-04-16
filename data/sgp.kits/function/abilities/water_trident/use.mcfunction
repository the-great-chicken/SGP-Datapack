#> sgp.kits:abilities/water_trident/use

advancement revoke @s only sgp.kits:water_trident

execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] run return 1

# Cooldown warning spam (runs every x tick you hold the charge while on CD)
execute if score @s sgp.cooldown_water_trident matches 1.. run return run function sgp.kits:abilities/water_trident/on_cooldown

# Water placement logic (only executes if NOT on cooldown)
execute at @s align xyz positioned ~ ~1 ~ \
    if block ~ ~ ~ #minecraft:air \
        unless entity @e[tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0,type=marker] \
            run function sgp.kits:abilities/water_trident/place_water

execute at @s align xyz positioned ~ ~ ~ \
    if block ~ ~ ~ #minecraft:air \
        unless entity @e[tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0,type=marker] \
            run function sgp.kits:abilities/water_trident/place_water

execute at @s anchored eyes positioned ^ ^ ^1 align xyz \
    if block ~ ~ ~ #minecraft:air \
        unless entity @e[tag=sgp.marker,name="temp_water",dx=0,dy=0,dz=0,type=marker] \
            run function sgp.kits:abilities/water_trident/place_water