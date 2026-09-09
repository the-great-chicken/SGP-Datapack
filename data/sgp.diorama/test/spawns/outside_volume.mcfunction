#> sgp.diorama:spawns/outside_volume
# @environment sgp.ci:diorama_spawns/outside_volume

function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_spawns/scenarios/outside_volume
