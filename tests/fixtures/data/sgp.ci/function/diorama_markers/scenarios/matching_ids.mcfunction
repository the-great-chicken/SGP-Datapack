#> sgp.ci:diorama_markers/scenarios/matching_ids

function sgp.ci:diorama_markers/fixture
function sgp.ci:diorama_markers/link
# Re-linking in reverse order must retain the correct map/model pairs.
execute as @e[tag=sgp.ci.markers_model_b,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
execute as @e[tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
function sgp.ci:diorama_markers/link
