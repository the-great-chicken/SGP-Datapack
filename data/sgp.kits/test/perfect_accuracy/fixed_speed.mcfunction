#> sgp.kits:perfect_accuracy/fixed_speed
# @dummy
# @environment sgp.ci:perfect_accuracy/fixed_speed
#
# Pearls, snowballs and eggs use their intended throw speed even with a weak initial launch.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/scenarios/fixed_speed
