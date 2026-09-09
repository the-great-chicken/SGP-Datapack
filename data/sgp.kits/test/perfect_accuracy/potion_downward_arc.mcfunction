#> sgp.kits:perfect_accuracy/potion_downward_arc
# @dummy
# @environment sgp.ci:perfect_accuracy/potion_downward_arc
#
# A downward-thrown potion remains downward despite the intended upward adjustment.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/scenarios/potion_downward_arc
