#> sgp.misc:tab/location/select
# `{lieu: string}`; executed as a location marker.

$scoreboard players operation @a[tag=sgp.tab_target,limit=1] sgp.tab_candidate = @a[tag=sgp.tab_target,limit=1] sgp.lieu_$(lieu)
data modify storage sgp:macro tab.location_candidate set from entity @s data
