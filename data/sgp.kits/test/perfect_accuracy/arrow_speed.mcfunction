#> sgp.kits:perfect_accuracy/arrow_speed
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Correct spread without replacing the bow's launch speed; a stationary arrow stays stationary.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/scenarios/arrow_speed
