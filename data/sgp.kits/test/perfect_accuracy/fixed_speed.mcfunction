#> sgp.kits:perfect_accuracy/fixed_speed
# @dummy
# @environment sgp.ci:perfect_accuracy/fixed_speed
#
# Pearls, snowballs and eggs use their intended throw speed even with a weak initial launch.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/scenarios/fixed_speed
