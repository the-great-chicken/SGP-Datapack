#> sgp.ci:diorama_spawns/scenarios/outside_volume

function sgp.ci:diorama_spawns/fixture
summon interaction 24.0 80.0 24.0 {Tags:["sgp.spawn_tper","sgp.ci.neighbor_button"]}
summon text_display 24.0 80.0 24.0 {Tags:["sgp.spawn_tper_text","sgp.ci.neighbor_label"],text:"Neighbor"}
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:2}
assert entity @e[tag=sgp.ci.neighbor_button,type=interaction]
assert entity @e[tag=sgp.ci.neighbor_label,type=text_display]
