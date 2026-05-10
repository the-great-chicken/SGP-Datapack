#> sgp.misc:diorama/spawn_entities/summon

data merge entity @s {Tags:["sgp.interaction","sgp.spawn_tper"], response:true, width:0.0625f, height:0.0625f, data:{function:"sgp.misc:interactions/tp_to_spawn"}}

data modify entity @s data.args set from storage sgp:data temp.spawns_list[0]

execute store result score @s bs.pos.x run data get storage sgp:data temp.spawns_list[0].x 1000
execute store result score @s bs.pos.y run data get storage sgp:data temp.spawns_list[0].y 1000
execute store result score @s bs.pos.z run data get storage sgp:data temp.spawns_list[0].z 1000

function sgp.misc:diorama/compute_diorama_pos

function #bs.position:set_pos {scale: 0.001}

execute store result score @s bs.rot.h run data get storage sgp:data temp.spawns_list[0].yaw 1000
execute store result score @s bs.rot.v run data get storage sgp:data temp.spawns_list[0].pitch 1000
function #bs.position:set_rot {scale: 0.001}