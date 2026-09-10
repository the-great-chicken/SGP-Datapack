#> sgp.diorama:markers/moved_model
# @environment sgp.ci:diorama_markers/moved_model

function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_markers/fixture
function sgp.ci:diorama_markers/link
execute as @n[tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/markers_pos {id:96004}
tp @e[tag=sgp.ci.markers_model_a,type=marker] 10.5 84.0 12.5
execute as @n[tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/markers_pos {id:96004}
assert score #model_96004_x sgp.dummy matches 10500
assert score #model_96004_y sgp.dummy matches 84000
assert score #model_96004_z sgp.dummy matches 12500
assert score #map_96004_x sgp.dummy matches 32000
assert score #map_96004_center_z sgp.dummy matches 64000
assert entity @e[tag=sgp.ci.markers_model_a,nbt={data:{mdx:1f,mdy:0f,mdz:3f}},type=marker]
