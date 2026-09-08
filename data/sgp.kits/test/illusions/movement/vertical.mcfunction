#> sgp.kits:illusions/movement/vertical
# @dummy
# @environment sgp.ci:illusions_movement/vertical
#
# Decoys follow a jump's height while retaining their horizontal formation.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:illusions_movement/scenarios/vertical
