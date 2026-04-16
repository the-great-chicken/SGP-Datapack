#> sgp.kits:abilities/tick

scoreboard players remove @a[tag=sgp.in_game,scores={sgp.cooldown_ability=1..}] sgp.cooldown_ability 1
scoreboard players remove @a[tag=sgp.in_game,scores={sgp.duration_ability=1..}] sgp.duration_ability 1

execute as @a[tag=sgp.in_game,scores={sgp.duration_ability=1..}] at @s run function sgp.kits:abilities/route_tick

execute as @a[scores={sgp.drop_any=1..}] at @s run function sgp.kits:abilities/main_trigger

function sgp.kits:abilities/water_trident/tick

# ===== Tick Abilities decoupled from player =====
function sgp.kits:abilities/smoke_grenade/tick


execute as @e[tag=sgp.giant_sweep,type=item_display] run function sgp.kits:abilities/cleave/animation_tick


execute as @e[tag=sgp.fire_explosion,type=marker] at @s run function sgp.kits:abilities/tnt/tick_fire
execute as @e[tag=sgp.tnt_interaction,type=interaction] run function #bs.link:imitate_pos