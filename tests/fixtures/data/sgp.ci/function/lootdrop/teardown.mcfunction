#> sgp.ci:lootdrop/teardown
# Environment teardown also runs when an assertion fails.

function sgp.ci:players/cleanup
function sgp.mineurs:lootdrop/clear_existing_ones
execute at @e[tag=sgp.ci.lootdrop.first,type=marker] run fill ~-3 ~-1 ~-3 ~11 ~4 ~6 air
kill @e[tag=sgp.ci.lootdrop,type=marker]
data remove storage sgp:data markers_lists.lootdrop
data modify storage sgp:data markers_lists.lootdrop set from storage sgp.ci:lootdrop previous.markers
data remove storage sgp.ci:lootdrop previous
