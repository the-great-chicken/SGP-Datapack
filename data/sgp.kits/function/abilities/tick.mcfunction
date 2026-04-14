#> sgp.kits:abilities/tick

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] sgp.cooldown_ability 1


# ===== Abilities ticking =====
scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_water_trident=1..}] sgp.cooldown_water_trident 1
execute as @a[tag=sgp.in_game,tag=sgp.poseidon] if items entity @s weapon.mainhand *[custom_data~{sgp.water_trident:true}] at @s run function sgp.kits:abilities/water_trident/manage_riptide
execute as @e[tag=sgp.marker,name="temp_water",type=marker] \
    at @s positioned ~-0.5 ~-0.5 ~-0.5 \
        unless entity @a[tag=sgp.in_game,dx=1,dy=1,dz=1] positioned ~0.5 ~0.5 ~0.5 \
            run function sgp.kits:abilities/water_trident/reset_water


# Prevents enabling ability into kit swapping exploit
execute as @a[scores={sgp.cooldown_ability=100}] \
    if data entity @s attributes[{id:"minecraft:scale"}].modifiers[{id:"sgp:bigger"}] \
        run function sgp.kits:abilities/bigger/disable


function sgp.kits:abilities/smoke_grenade/tick


# Make mannequins imitate players
# As soon as https://github.com/mcbookshelf/bookshelf/issues/38 is implemented, make everything use bookshelf
execute as @a[tag=sgp.in_game,tag=sgp.alchimiste,team=sgp.Illusion] at @s run function sgp.kits:abilities/illusions/tick


execute as @e[tag=sgp.giant_sweep,type=item_display] run function sgp.kits:abilities/cleave/animation_tick

# We need to know the attack damage of the player for Cleave, but if he drops his weapon, the attribute becomes 1...
# This should get optimized if a solution is found (we shouldn't have to edit a score every time)
execute as @a[tag=sgp.in_game] unless score @s sgp.drop_any matches 1.. store result score @s sgp.current_attack_damage run attribute @s attack_damage get 10


execute as @e[tag=sgp.fire_explosion,type=marker] at @s run function sgp.kits:abilities/tnt/do_fire
execute as @e[tag=sgp.tnt_interaction,type=interaction] run function #bs.link:imitate_pos


execute as @a[tag=sgp.is_pecking] anchored eyes at @s run function sgp.kits:abilities/pecking/damage


execute as @a[tag=sgp.assassin] at @s run function sgp.kits:abilities/assassinate/particles


execute as @a[tag=sgp.is_radiating] at @s run function sgp.kits:abilities/rays/tick


# ===== Ability triggering =====
execute as @a[scores={sgp.drop_any=1..}] at @s run function sgp.kits:abilities/main_trigger