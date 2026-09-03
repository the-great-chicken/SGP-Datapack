#> sgp.diorama:hover/loop/shrink/recursion
# `{uuid: entity uuid}`

$execute as $(uuid) at @s if entity @s[tag=sgp.spawn_hovered] run function sgp.diorama:hover/shrink
data remove storage sgp:data temp.hover_loop_list[0]

execute unless data storage sgp:data temp.hover_loop_list[0] run return 1
function sgp.diorama:hover/loop/shrink/recursion with storage sgp:data temp.hover_loop_list[0]
