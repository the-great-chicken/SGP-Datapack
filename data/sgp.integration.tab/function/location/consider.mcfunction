#> sgp.integration.tab:location/consider
# `{lieu: string}`; executed as a location marker.

$execute if score @a[tag=sgp.tab_target,limit=1] sgp.lieu_$(lieu) > @a[tag=sgp.tab_target,limit=1] sgp.tab_candidate run function sgp.integration.tab:location/select with entity @s data
