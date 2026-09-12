#> sgp.ci:pyromane_fire/tick
# Advance only this scenario's fire through its production update.

execute as @e[tag=sgp.ci.fire,type=marker] at @s run function sgp.kits:abilities/tnt/tick_fire
