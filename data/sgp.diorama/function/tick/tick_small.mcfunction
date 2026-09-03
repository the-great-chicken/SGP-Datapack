#> sgp.diorama:tick/tick_small
# `{id: int}`

function sgp.diorama:tick/check_for_spawned_player with entity @s data
data modify storage sgp:data temp.diorama set from entity @s data
$execute as @a[tag=sgp.has_small_mannequin_$(id)] at @s run function sgp.diorama:tick/update_mannequin/update_small_pos with storage sgp:data temp.diorama