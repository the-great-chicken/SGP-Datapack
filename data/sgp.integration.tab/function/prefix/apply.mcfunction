#> sgp.integration.tab:prefix/apply
# `{kit_name: string}`

scoreboard players set @a[tag=sgp.tab_target,limit=1] sgp.kit_prefix_set 1
$luckperms user @a[tag=sgp.tab_target,limit=1] parent settrack kit $(kit_name)
tag @a[tag=sgp.tab_target,limit=1] remove sgp.tab_target

scoreboard players set #tab_refresh sgp.dummy 1
scoreboard players set #tab_queue_turn sgp.dummy 0
return 1
