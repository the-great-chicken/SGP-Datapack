#> sgp.kits:illusions/movement/vertical
# @dummy
# @environment sgp.ci:illusions_movement/vertical
#
# Decoys follow a jump's height while retaining their horizontal formation.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:illusions_movement/scenarios/vertical
