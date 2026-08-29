#> sgp.diorama:tick/on_player_spawn
# `{id: int}`

$tag @s add sgp.has_small_mannequin_$(id)

data modify storage sgp:data misc.diorama.current_uuid set from entity @s UUID
data modify storage sgp:data misc.diorama.type set value "small"
data modify storage sgp:data misc.diorama.size set value "0.0625"
$data modify storage sgp:data misc.diorama.id set value $(id)
function sgp.diorama:tick/update_mannequin/summon with storage sgp:data misc.diorama