#> sgp.kits:perfect_accuracy/potion_arc
# @dummy
# @environment sgp.ci:perfect_accuracy/potion_arc
#
# A splash potion follows horizontal aim while retaining an upward arc.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/scenarios/potion_arc
