#> sgp.kits:illusions/movement/facing
# @dummy
# @environment sgp.ci:illusions_movement/facing
#
# Each decoy preserves the caster's pitch and faces its own side of the formation.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:illusions_movement/scenarios/facing
