#> sgp.diorama:hover/loop/check_filtered/recursion
# `{uuid: entity uuid}`

$execute as $(uuid) at @s run function sgp.diorama:hover/check_target_filtered
data remove storage sgp:data temp.hover_loop_list[0]

execute unless data storage sgp:data temp.hover_loop_list[0] run return 1
function sgp.diorama:hover/loop/check_filtered/recursion with storage sgp:data temp.hover_loop_list[0]
