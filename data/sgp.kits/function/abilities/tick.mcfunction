scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_repulsion=1..}] sgp.cooldown_repulsion 1

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_water_trident=1..}] sgp.cooldown_water_trident 1
execute as @a[tag=sgp.in_game,tag=sgp.poseidon] if items entity @s weapon.mainhand *[custom_data~{sgp.water_trident:true}] at @s run function sgp.kits:abilities/water_trident/manage_riptide
execute as @e[type=marker,tag=sgp.marker,name="temp_water"] \
    at @s positioned ~-1 ~-1 ~-1 \
        unless entity @a[tag=sgp.in_game,dx=2,dy=2,dz=2] positioned ~1 ~1 ~1 \
            run function sgp.kits:abilities/water_trident/reset_water

execute as @a[scores={sgp.drop_any=1..}] at @s run function sgp.kits:abilities/main_trigger