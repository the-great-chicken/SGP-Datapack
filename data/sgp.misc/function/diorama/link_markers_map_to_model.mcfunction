#> sgp.misc:diorama/link_markers_map_to_model
#
# Cycles through the map markers to find the one with the same id as the map model marker

execute store result score #to_compare sgp.dummy run data get entity @s data.id
execute as @e[tag=sgp.marker,name=playable_map,type=marker] store result score @s sgp.dummy run data get entity @s data.id
execute as @e[tag=sgp.marker,name=playable_map,type=marker] if score @s sgp.dummy = #to_compare sgp.dummy run function #bs.link:create_link_ata