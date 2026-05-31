#> sgp.misc:diorama/spawn_entities/summon
# `{id: int}`

data merge entity @s {Tags:["sgp.interaction","sgp.spawn_tper"], response:true, width:0.14f, height:0.14f, data:{function:"sgp.misc:interactions/tp_to_spawn"}}

data modify entity @s data.args set from storage sgp:data temp.spawns_list[0]
$data modify entity @s data.args.id set value $(id)

execute store result score @s bs.pos.x run data get storage sgp:data temp.spawns_list[0].x 1000
execute store result score @s bs.pos.y run data get storage sgp:data temp.spawns_list[0].y 1000
execute store result score @s bs.pos.z run data get storage sgp:data temp.spawns_list[0].z 1000

$function sgp.misc:diorama/compute_diorama_pos {id:$(id)}

function #bs.position:set_pos {scale: 0.001}

execute store result score @s bs.rot.h run data get storage sgp:data temp.spawns_list[0].yaw 1000
execute store result score @s bs.rot.v run data get storage sgp:data temp.spawns_list[0].pitch 1000
function #bs.position:set_rot {scale: 0.001}

execute at @s summon text_display run function sgp.misc:diorama/spawn_entities/set_text_name with entity @e[tag=sgp.spawn_tper,distance=..0.01,limit=1,type=interaction] data.args