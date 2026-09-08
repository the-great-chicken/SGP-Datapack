#> sgp.kits:illusions/movement/pose
# @dummy
# @environment sgp.ci:illusions_movement/pose
#
# Crouching and standing apply on the current update, independently for each caster.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:illusions_movement/scenarios/pose_1
await predicate sgp.misc:is_sneaking
function sgp.ci:illusions_movement/scenarios/pose_2
await not predicate sgp.misc:is_sneaking
function sgp.ci:illusions_movement/scenarios/pose_3
