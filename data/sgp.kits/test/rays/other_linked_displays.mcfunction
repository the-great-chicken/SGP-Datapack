#> sgp.kits:rays/other_linked_displays
# @dummy
# @environment sgp.ci:rays/other_linked_displays
#
# Other linked displays do not consume the eight-beam update limit.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/scenarios/other_linked_displays
