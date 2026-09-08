#> sgp.kits:perfect_accuracy/aim
# @dummy
# @environment sgp.ci:perfect_accuracy/aim
#
# Horizontal and vertical aim both determine the corrected trajectory.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/scenarios/aim
