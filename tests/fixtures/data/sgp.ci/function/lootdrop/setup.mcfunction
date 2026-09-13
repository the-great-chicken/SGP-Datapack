#> sgp.ci:lootdrop/setup
# Preserve the marker registry used by the real tick function.

function sgp.ci:players/cleanup
data modify storage sgp.ci:lootdrop previous set value {}
data modify storage sgp.ci:lootdrop previous.markers set from storage sgp:data markers_lists.lootdrop
data modify storage sgp:data markers_lists.lootdrop set value []
