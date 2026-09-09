#> sgp.ci:kill_effects/dispatch

# Invoke the death hook directly after recording the attacker, without entering death/statistics processing.
execute as EffectVictim at @s run function sgp.cosmetics:kill_effects/death_reaper
execute positioned ~5.5 ~1 ~5.5 run tag @e[distance=..16,type=falling_block] add sgp.ci.kill_effect
execute positioned ~5.5 ~1 ~5.5 run tag @e[distance=..16,type=firework_rocket] add sgp.ci.kill_effect
