#> sgp.kits:perfect_accuracy/arrow_speed
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Correct spread without replacing the bow's launch speed; a stationary arrow stays stationary.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/scenarios/arrow_speed
