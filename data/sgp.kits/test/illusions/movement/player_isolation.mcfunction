#> sgp.kits:illusions/movement/player_isolation
# @dummy
# @environment sgp.ci:illusions_movement/player_isolation
#
# Updating one caster leaves the other caster's formation where it was.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:illusions_movement/scenarios/player_isolation
