#> sgp.diorama:tick/tick_giant
# `{id: int}`

function sgp.diorama:tick/check_for_giant_player with entity @s data
function sgp.diorama:hover/model with entity @s data
data modify storage sgp:data temp.diorama set from entity @s data
$execute as @a[tag=sgp.has_giant_mannequin_$(id)] at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos with storage sgp:data temp.diorama
