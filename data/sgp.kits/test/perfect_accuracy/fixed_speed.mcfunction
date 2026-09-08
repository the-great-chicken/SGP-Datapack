#> sgp.kits:perfect_accuracy/fixed_speed
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Pearls, snowballs and eggs use their intended throw speed even with a weak initial launch.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/clear_projectiles

execute at @s run function sgp.ci:perfect_accuracy/throw {type:ender_pearl}
execute at @s run function sgp.ci:perfect_accuracy/throw {type:snowball}
execute at @s run function sgp.ci:perfect_accuracy/throw {type:egg}
