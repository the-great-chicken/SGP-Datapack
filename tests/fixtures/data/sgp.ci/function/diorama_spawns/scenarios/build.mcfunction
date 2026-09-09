#> sgp.ci:diorama_spawns/scenarios/build

function sgp.ci:diorama_spawns/fixture
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:2}
execute positioned 9.0 80.0 9.0 run assert entity @e[tag=sgp.spawn_tper,distance=..0.01,nbt={data:{function:"sgp.misc:interactions/tp_to_spawn",args:{id:96003,x:48.0d,y:80.0d,z:48.0d,yaw:90.0d,title:{text:"First"}}}},type=interaction]
execute positioned 11.0 80.0 11.0 run assert entity @e[tag=sgp.spawn_tper,distance=..0.01,nbt={data:{args:{x:80.0d,z:80.0d,title:{text:"Second"}}}},type=interaction]
execute as @n[tag=sgp.spawn_tper,nbt={data:{args:{title:{text:"First"}}}},type=interaction] run function sgp.ci:diorama_spawns/label {title:First,icon:A}
assert data storage sgp:data misc.diorama.spawn_interactions.id_96003[1]
assert not data storage sgp:data misc.diorama.spawn_interactions.id_96003[2]
function sgp.ci:diorama_spawns/cached_button with storage sgp:data misc.diorama.spawn_interactions.id_96003[0]
function sgp.ci:diorama_spawns/cached_button with storage sgp:data misc.diorama.spawn_interactions.id_96003[1]
