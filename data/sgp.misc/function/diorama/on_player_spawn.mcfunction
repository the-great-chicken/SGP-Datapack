#> sgp.misc:diorama/on_player_spawn
# `{uuid: playable_map_model marker uuid}`

tag @s add sgp.has_small_mannequin

data modify storage sgp:data misc.diorama.current_uuid set from entity @s UUID
data modify storage sgp:data misc.diorama.type set value "small"
data modify storage sgp:data misc.diorama.size set value "0.0625"
$execute at $(uuid) run function sgp.misc:diorama/summon with storage sgp:data misc.diorama