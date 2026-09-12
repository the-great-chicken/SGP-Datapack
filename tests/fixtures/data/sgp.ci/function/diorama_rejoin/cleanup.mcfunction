#> sgp.ci:diorama_rejoin/cleanup
function sgp.ci:diorama_lifecycle/cleanup
fill 32 80 32 39 80 39 air
fill 4 80 4 12 80 12 air
data remove storage sgp:data markers_lists.playable_map
data remove storage sgp:data markers_lists.playable_map_model
data modify storage sgp:data markers_lists.playable_map set from storage sgp.ci:diorama_rejoin backup.maps
data modify storage sgp:data markers_lists.playable_map_model set from storage sgp.ci:diorama_rejoin backup.models
execute store result score #mannequin_update_time sgp.dummy run data get storage sgp.ci:diorama_rejoin backup.update_time
execute store result score #giant_offset sgp.dummy run data get storage sgp.ci:diorama_rejoin backup.offset
data remove storage sgp.ci:diorama_rejoin backup
data remove storage sgp.ci:diorama_rejoin uuid
