#> sgp.diorama:tick/on_player_around_model
# `{id: int}`

$tag @s add sgp.has_giant_mannequin_$(id)

data modify storage sgp:data misc.diorama.current_uuid set from entity @s UUID
data modify storage sgp:data misc.diorama.type set value "giant"
data modify storage sgp:data misc.diorama.size set value "16"
$data modify storage sgp:data misc.diorama.id set value $(id)
function sgp.diorama:tick/update_mannequin/summon with storage sgp:data misc.diorama