#> sgp.misc:player_mannequins/on_player_spawn

tag @s add sgp.has_small_mannequin

data modify storage sgp:data misc.player_mannequins.current_uuid set from entity @s UUID
data modify storage sgp:data misc.player_mannequins.type set value "small"
data modify storage sgp:data misc.player_mannequins.size set value "0.0625"
execute at @e[tag=sgp.marker,name=playable_map_model,type=marker] run function sgp.misc:player_mannequins/summon with storage sgp:data misc.player_mannequins