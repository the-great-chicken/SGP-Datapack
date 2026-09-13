#> sgp.ci:diorama_rejoin/setup
function sgp.ci:diorama_lifecycle/setup
data modify storage sgp.ci:diorama_rejoin backup set value {}
data modify storage sgp.ci:diorama_rejoin backup.maps set from storage sgp:data markers_lists.playable_map
data modify storage sgp.ci:diorama_rejoin backup.models set from storage sgp:data markers_lists.playable_map_model
execute store result storage sgp.ci:diorama_rejoin backup.update_time int 1 run scoreboard players get #mannequin_update_time sgp.dummy
execute store result storage sgp.ci:diorama_rejoin backup.offset int 1 run scoreboard players get #giant_offset sgp.dummy
