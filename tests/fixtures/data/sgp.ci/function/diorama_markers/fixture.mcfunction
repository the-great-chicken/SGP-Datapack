#> sgp.ci:diorama_markers/fixture
# `{owner: string, id_a: int, id_b: int, y: double}`
# Create two test-owned map/model marker pairs with matching IDs but no pre-existing links.

$summon marker 32.0 $(y) 32.0 {Tags:["sgp.ci.diorama_markers","sgp.ci.diorama_markers_$(owner)","sgp.ci.markers_map_a","sgp.marker"],CustomName:"playable_map",data:{id:$(id_a),dx:32,dy:16,dz:64}}
$summon marker 64.0 $(y) 32.0 {Tags:["sgp.ci.diorama_markers","sgp.ci.diorama_markers_$(owner)","sgp.ci.markers_map_b","sgp.marker"],CustomName:"playable_map",data:{id:$(id_b),dx:16,dy:16,dz:16}}
$summon marker 8.0 $(y) 8.0 {Tags:["sgp.ci.diorama_markers","sgp.ci.diorama_markers_$(owner)","sgp.ci.markers_model_a","sgp.marker"],CustomName:"playable_map_model",data:{id:$(id_a)}}
$summon marker 12.0 $(y) 8.0 {Tags:["sgp.ci.diorama_markers","sgp.ci.diorama_markers_$(owner)","sgp.ci.markers_model_b","sgp.marker"],CustomName:"playable_map_model",data:{id:$(id_b)}}
