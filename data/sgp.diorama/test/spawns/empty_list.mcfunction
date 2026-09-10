#> sgp.diorama:spawns/empty_list
# @environment sgp.ci:diorama_spawns/empty_list

function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_spawns/fixture
function sgp.ci:diorama_spawns/rebuild
data modify storage sgp:data spawns[{id:96003}].list set value []
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:0}
assert not data storage sgp:data misc.diorama.spawn_interactions.id_96003[0]
