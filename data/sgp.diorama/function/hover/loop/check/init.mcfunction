#> sgp.diorama:hover/loop/check/init
# `{list_location: nbt path}`
# Dedicated loop state prevents clobbering the outer marker UUID loop.

$data modify storage sgp:data temp.hover_loop_list set from storage sgp:data $(list_location)
execute unless data storage sgp:data temp.hover_loop_list[0] run return 0
function sgp.diorama:hover/loop/check/recursion with storage sgp:data temp.hover_loop_list[0]
