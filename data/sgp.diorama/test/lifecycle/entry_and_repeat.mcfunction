#> sgp.diorama:lifecycle/entry_and_repeat
# @dummy
# @environment sgp.ci:diorama_lifecycle/entry_and_repeat

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/scenarios/entry_and_repeat
