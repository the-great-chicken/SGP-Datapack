#> sgp.ci:diorama_markers/link
# Run production marker linking and assert each playable map links to the model with the same ID.

execute as @e[tag=sgp.ci.markers_model_a,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
execute as @e[tag=sgp.ci.markers_model_b,type=marker] at @s run function sgp.diorama:init/link_markers_map_to_model
assert score @n[tag=sgp.ci.markers_map_a,type=marker] bs.link.to = @n[tag=sgp.ci.markers_model_a,type=marker] bs.id
assert score @n[tag=sgp.ci.markers_map_b,type=marker] bs.link.to = @n[tag=sgp.ci.markers_model_b,type=marker] bs.id
