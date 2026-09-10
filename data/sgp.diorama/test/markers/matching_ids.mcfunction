#> sgp.diorama:markers/matching_ids
# @environment sgp.ci:diorama_markers/matching_ids

function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_markers/fixture
function sgp.ci:diorama_markers/link
# Re-linking in reverse order must retain the correct map/model pairs.
execute as @e[tag=sgp.ci.markers_model_b,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
execute as @e[tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
function sgp.ci:diorama_markers/link
