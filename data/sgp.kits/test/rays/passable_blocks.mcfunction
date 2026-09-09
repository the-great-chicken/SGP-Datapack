#> sgp.kits:rays/passable_blocks
# @dummy
# @environment sgp.ci:rays/passable_blocks
#
# A beam passes through water but still stops at the solid block behind it.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/scenarios/passable_blocks
