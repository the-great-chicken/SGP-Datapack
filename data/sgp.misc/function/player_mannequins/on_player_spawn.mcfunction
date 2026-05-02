#> sgp.misc:player_mannequins/on_player_spawn
# `{uuid: playable_map_model marker uuid}`

tag @s add sgp.has_small_mannequin

data modify storage sgp:data misc.player_mannequins.current_uuid set from entity @s UUID
data modify storage sgp:data misc.player_mannequins.type set value "small"
data modify storage sgp:data misc.player_mannequins.size set value "0.0625"
$execute at $(uuid) run function sgp.misc:player_mannequins/summon with storage sgp:data misc.player_mannequins