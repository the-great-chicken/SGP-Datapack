#> sgp.ci:diorama_spawns/scenarios/overlapping_buttons

function sgp.ci:diorama_spawns/fixture
data modify storage sgp:data spawns[{id:96003}].list[1].x set value 48.0d
data modify storage sgp:data spawns[{id:96003}].list[1].z set value 48.0d
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:2}
assert entity @e[tag=sgp.spawn_tper,nbt={data:{args:{title:{text:"First"}}}},type=interaction]
assert entity @e[tag=sgp.spawn_tper,nbt={data:{args:{title:{text:"Second"}}}},type=interaction]
execute as @n[tag=sgp.spawn_tper,nbt={data:{args:{title:{text:"First"}}}},type=interaction] run function sgp.ci:diorama_spawns/label {title:First,icon:A}
execute as @n[tag=sgp.spawn_tper,nbt={data:{args:{title:{text:"Second"}}}},type=interaction] run function sgp.ci:diorama_spawns/label {title:Second,icon:B}
