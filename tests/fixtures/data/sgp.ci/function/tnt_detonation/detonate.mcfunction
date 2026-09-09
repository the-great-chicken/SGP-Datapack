#> sgp.ci:tnt_detonation/detonate

# {target}: synchronous detonation phase before vanilla removes the charge.
$execute as @e[tag=sgp.ci.click_tnt_$(target),type=tnt] at @s run function sgp.kits:abilities/tnt/summon_fire
execute positioned ~2.5 ~1 ~0.5 run tag @e[tag=sgp.fire_explosion,distance=..8,type=marker] add sgp.ci.detonation_fire
