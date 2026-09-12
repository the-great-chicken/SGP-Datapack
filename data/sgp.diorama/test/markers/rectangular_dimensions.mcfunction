#> sgp.diorama:markers/rectangular_dimensions
# @environment sgp.ci:diorama_markers/rectangular_dimensions

function sgp.ci:diorama_markers/ready {owner:"rectangular_dimensions"}
await entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.diorama_markers_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.diorama_markers_ready,type=marker]
function sgp.ci:diorama_markers/fixture {owner:"rectangular_dimensions",id_a:96104,id_b:96105,y:96.0}
# /forceload is asynchronous: wait for the freshly summoned entities themselves to become selector-visible.
await entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_map_a,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_map_b,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_model_a,type=marker]
await entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_model_b,type=marker]
function sgp.ci:diorama_markers/link {owner:"rectangular_dimensions"}
execute as @n[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/markers_pos {id:96104}
assert score #map_96104_x sgp.dummy matches 32000
assert score #map_96104_y sgp.dummy matches 96000
assert score #map_96104_z sgp.dummy matches 32000
assert score #model_96104_x sgp.dummy matches 8000
assert score #map_96104_center_x sgp.dummy matches 48000
assert score #map_96104_center_z sgp.dummy matches 64000
assert entity @e[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_model_a,nbt={data:{mdx:1f,mdy:0f,mdz:3f,mdx_end:10f,mdy_end:9f,mdz_end:12f}},type=marker]
assert not data entity @n[tag=sgp.ci.diorama_markers_rectangular_dimensions,tag=sgp.ci.markers_model_b,type=marker] data.mdx
