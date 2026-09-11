#> sgp.diorama:markers/matching_ids
# @environment sgp.ci:diorama_markers/matching_ids

function sgp.ci:diorama_markers/ready {owner:"matching_ids"}
await entity @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.diorama_markers_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.diorama_markers_ready,type=marker]
function sgp.ci:diorama_markers/fixture {owner:"matching_ids",id_a:96204,id_b:96205,y:112.0}
# /forceload is asynchronous: wait for the freshly summoned entities themselves to become selector-visible.
await entity @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_map_a,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_map_b,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_model_a,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_model_b,type=marker]
function sgp.ci:diorama_markers/link {owner:"matching_ids"}
# Re-linking in reverse order must retain the correct map/model pairs.
execute as @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_model_b,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
execute as @e[tag=sgp.ci.diorama_markers_matching_ids,tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
function sgp.ci:diorama_markers/link {owner:"matching_ids"}
