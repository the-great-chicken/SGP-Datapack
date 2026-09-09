#> sgp.ci:diorama_spawns/cleanup
function sgp.ci:players/cleanup
execute positioned 8.0 80.0 8.0 run kill @e[tag=sgp.spawn_tper,distance=..24,type=interaction]
execute positioned 8.0 80.0 8.0 run kill @e[tag=sgp.spawn_tper_text,distance=..24,type=text_display]
kill @e[tag=sgp.ci.menu,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
data remove storage sgp:data spawns[{id:96003}]
data remove storage sgp:data misc.diorama.spawn_interactions.id_96003
