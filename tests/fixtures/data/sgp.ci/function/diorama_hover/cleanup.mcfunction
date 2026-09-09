#> sgp.ci:diorama_hover/cleanup
function sgp.ci:players/cleanup
kill @e[tag=sgp.ci.hover,type=interaction]
kill @e[tag=sgp.ci.hover,type=text_display]
kill @e[tag=sgp.ci.hover,type=marker]
data remove storage sgp:data misc.diorama.spawn_interactions.id_93001
