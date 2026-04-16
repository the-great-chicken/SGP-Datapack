#> sgp.kits:abilities/water_trident/tick

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_water_trident=1..}] sgp.cooldown_water_trident 1

execute as @a[tag=sgp.in_game,tag=sgp.poseidon] if items entity @s weapon.mainhand *[custom_data~{sgp.water_trident:true}] at @s run function sgp.kits:abilities/water_trident/manage_riptide

execute as @e[tag=sgp.marker,name="temp_water",type=marker] \
    at @s positioned ~-0.5 ~-0.5 ~-0.5 \
        unless entity @a[tag=sgp.in_game,dx=1,dy=1,dz=1] positioned ~0.5 ~0.5 ~0.5 \
            run function sgp.kits:abilities/water_trident/reset_water