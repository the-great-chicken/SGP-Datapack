#> sgp.kits:illusions/movement/facing
# @dummy
# @environment sgp.ci:illusions_movement/facing
#
# Each decoy preserves the caster's pitch and faces its own side of the formation.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:illusions_movement/scenarios/facing
