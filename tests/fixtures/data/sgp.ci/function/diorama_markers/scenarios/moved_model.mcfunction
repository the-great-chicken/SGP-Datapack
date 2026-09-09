#> sgp.ci:diorama_markers/scenarios/moved_model

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
