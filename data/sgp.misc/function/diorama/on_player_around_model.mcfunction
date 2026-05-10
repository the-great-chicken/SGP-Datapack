#> sgp.misc:diorama/on_player_around_model
# `{uuid: playable_map marker uuid}`

tag @s add sgp.has_giant_mannequin

data modify storage sgp:data misc.diorama.current_uuid set from entity @s UUID
data modify storage sgp:data misc.diorama.type set value "giant"
data modify storage sgp:data misc.diorama.size set value "16"
$execute at $(uuid) run function sgp.misc:diorama/summon with storage sgp:data misc.diorama