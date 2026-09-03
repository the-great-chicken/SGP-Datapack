#> sgp.kits:abilities/water_trident/use

advancement revoke @s only sgp.kits:water_trident

execute unless entity @s[tag=sgp.in_game,tag=sgp.poseidon] run return 0
execute unless items entity @s weapon.mainhand *[custom_data~{sgp.water_trident:true}] run return 0

execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] run return 1

# Cooldown warning spam (runs every x tick you hold the charge while on CD)
execute if score @s sgp.cooldown_ability matches 1.. run return run function sgp.kits:abilities/water_trident/on_cooldown

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

# A single use can place water in more than one candidate block. Record the
# activation once here, after any successful placement has started the cooldown.
execute if score @s sgp.cooldown_ability matches 1.. \
    run function sgp.kits:stats_collector/ability/start {kit_id:11,ability_path:"water_trident"}

# If no air block was found, reapply riptide to avoid the trident being launched
execute if score @s sgp.cooldown_ability matches ..0 \
    run item modify entity @s weapon.mainhand sgp.kits:add_riptide
