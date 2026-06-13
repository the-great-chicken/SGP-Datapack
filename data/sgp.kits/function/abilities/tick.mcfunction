#> sgp.kits:abilities/tick

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] sgp.cooldown_ability 1
scoreboard players remove @a[tag=sgp.in_game,scores={sgp.duration_ability=1..}] sgp.duration_ability 1

execute as @a[tag=sgp.in_game,scores={sgp.duration_ability=1..}] at @s run function sgp.kits:abilities/route_tick

execute as @a[scores={sgp.drop_any=1..}] at @s run function sgp.kits:abilities/main_trigger

# Refresh the visible main ability cooldown after it has been decremented, and after a newly triggered ability may have started its cooldown.
execute as @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] \
    run function sgp.misc:actionbar/ability_cooldown

execute as @a[scores={sgp.ab.ability_cooldown=1,sgp.cooldown_ability=..0}] \
    run function dah.actbar_mixer:remove/this {id:"sgp:ability_cooldown"}

function sgp.kits:abilities/water_trident/tick

# Refresh the visible water-trident cooldown after its own cooldown tick.
execute as @a[tag=sgp.in_game,scores={sgp.cooldown_water_trident=1..}] run function sgp.misc:actionbar/water_trident_cooldown
execute as @a[scores={sgp.ab.water_trident_cooldown=1,sgp.cooldown_water_trident=..0}] run function dah.actbar_mixer:remove/this {id:"sgp:water_trident_cooldown"}

# ===== Tick Abilities decoupled from player =====
function sgp.kits:abilities/smoke_grenade/tick


execute as @e[tag=sgp.giant_sweep,type=item_display] run function sgp.kits:abilities/cleave/animation_tick


execute as @e[tag=sgp.fire_explosion,type=marker] at @s run function sgp.kits:abilities/tnt/tick_fire
execute as @e[tag=sgp.tnt_interaction,type=interaction] run function #bs.link:imitate_pos