#> sgp.misc:tab/location/apply
# `{lieu: string}`

$execute if score @a[tag=sgp.tab_target,limit=1] sgp.tab_applied matches 1 if entity @a[tag=sgp.tab_target,tag=sgp.tab.location.$(lieu),limit=1] run return run function sgp.misc:tab/location/no_change

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.location", command:"run function sgp.misc:tab/location/remove_applied_tag with entity @s data"}
$tag @a[tag=sgp.tab_target,limit=1] add sgp.tab.location.$(lieu)

$luckperms user @a[tag=sgp.tab_target,limit=1] parent settrack sgp-location sgp-loc-$(lieu)
scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.tab_applied 1
scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.tab_dirty -1
tag @a[tag=sgp.tab_target,limit=1] remove sgp.tab_target

scoreboard players set #tab_refresh sgp.dummy 1
scoreboard players set #tab_queue_turn sgp.dummy 1
return 1
