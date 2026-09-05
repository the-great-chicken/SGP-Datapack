#> sgp.integration.tab:location/clear

execute if score @a[tag=sgp.tab_target,limit=1] sgp.tab_applied matches 0 run return run function sgp.integration.tab:location/no_change

luckperms user @a[tag=sgp.tab_target,limit=1] parent cleartrack sgp-location
function sgp.misc:loop_as_entity/init {list_location:"markers_lists.location", command:"run function sgp.integration.tab:location/remove_applied_tag with entity @s data"}

scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.tab_applied 0
scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.tab_dirty -1
tag @a[tag=sgp.tab_target,limit=1] remove sgp.tab_target

scoreboard players set #tab_refresh sgp.dummy 1
scoreboard players set #tab_queue_turn sgp.dummy 1
return 1
