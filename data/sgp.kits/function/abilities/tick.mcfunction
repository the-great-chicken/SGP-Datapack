scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] sgp.cooldown_ability 1

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_water_trident=1..}] sgp.cooldown_water_trident 1
execute as @a[tag=sgp.in_game,tag=sgp.poseidon] if items entity @s weapon.mainhand *[custom_data~{sgp.water_trident:true}] at @s run function sgp.kits:abilities/water_trident/manage_riptide
execute as @e[type=marker,tag=sgp.marker,name="temp_water"] \
    at @s positioned ~-0.5 ~-0.5 ~-0.5 \
        unless entity @a[tag=sgp.in_game,dx=1,dy=1,dz=1] positioned ~0.5 ~0.5 ~0.5 \
            run function sgp.kits:abilities/water_trident/reset_water

# Prevents enabling ability into kit swapping exploit
execute as @a[scores={sgp.cooldown_ability=100}] \
    if data entity @s attributes[{id:"minecraft:scale"}].modifiers[{id:"sgp:bigger"}] \
        run function sgp.kits:abilities/bigger/disable

# Detect when a smoke grenade hits the ground
tag @e[type=item_display,tag=sgp.smoke_visual] remove sgp.is_riding
execute as @e[type=snowball,tag=sgp.smoke_grenade] at @s run tag @e[type=item_display,tag=sgp.smoke_visual,distance=..0.5,limit=1] add sgp.is_riding
execute as @e[type=item_display,tag=sgp.smoke_visual,tag=!sgp.is_riding] at @s run function sgp.kits:abilities/smoke_grenade/on_ground

# Make mannequins imitate players
# As soon as https://github.com/mcbookshelf/bookshelf/issues/38 is implemented, make everything use bookshelf
execute as @a[tag=sgp.in_game,tag=sgp.alchimiste] at @s run function sgp.kits:abilities/illusions/tick

execute as @a[scores={sgp.drop_any=1..}] at @s run function sgp.kits:abilities/main_trigger