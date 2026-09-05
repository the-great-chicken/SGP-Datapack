#> sgp.misc:tab/location/enter
# `{lieu: string}`
# Store a global entry serial in the existing per-location score. The largest
# active serial is therefore the most recently entered overlapping location.

scoreboard players add #tab_location_serial sgp.dummy 1
$scoreboard players operation @s sgp.lieu_$(lieu) = #tab_location_serial sgp.dummy
scoreboard players set @s sgp.tab_dirty 5
