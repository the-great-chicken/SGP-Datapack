#> sgp.diorama:spawns/rebuild
# @environment sgp.ci:diorama_spawns/rebuild

function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_spawns/fixture
function sgp.ci:diorama_spawns/rebuild
tag @e[tag=sgp.spawn_tper,type=interaction] add sgp.ci.old_button
tag @e[tag=sgp.spawn_tper_text,type=text_display] add sgp.ci.old_label
data modify storage sgp:data spawns[{id:96003}].list set value [{x:64.0,y:96.0,z:64.0,yaw:0.0,pitch:0.0,article:"au",title:{text:"New"},icon:"N"}]
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:1}
assert not entity @e[tag=sgp.ci.old_button,type=interaction]
assert not entity @e[tag=sgp.ci.old_label,type=text_display]
execute positioned 10.0 81.0 10.0 run assert entity @e[tag=sgp.spawn_tper,distance=..0.01,nbt={data:{args:{title:{text:"New"}}}},type=interaction]
assert data storage sgp:data misc.diorama.spawn_interactions.id_96003[0]
assert not data storage sgp:data misc.diorama.spawn_interactions.id_96003[1]
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:1}
