#> sgp.misc:tab/location/update
# Resolve one debounced player. A cached applied-group tag suppresses no-op LP
# commands when a non-winning overlap changes or an A -> B -> A burst settles.

tag @a remove sgp.tab_target
tag @a[scores={sgp.tab_dirty=0},limit=1,sort=arbitrary] add sgp.tab_target

scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.tab_candidate 1
data remove storage sgp:macro tab.location_candidate

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.location", command:"run function sgp.misc:tab/location/consider with entity @s data"}

execute unless data storage sgp:macro tab.location_candidate.lieu run return run function sgp.misc:tab/location/clear
return run function sgp.misc:tab/location/apply with storage sgp:macro tab.location_candidate
