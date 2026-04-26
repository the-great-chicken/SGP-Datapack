#> sgp.misc:player_mannequins/on_player_around_model

tag @s add sgp.has_giant_mannequin

data modify storage sgp:data misc.player_mannequins.current_uuid set from entity @s UUID
data modify storage sgp:data misc.player_mannequins.type set value "giant"
data modify storage sgp:data misc.player_mannequins.size set value "16"
execute at @e[tag=sgp.marker,name=playable_map,type=marker] run function sgp.misc:player_mannequins/summon with storage sgp:data misc.player_mannequins