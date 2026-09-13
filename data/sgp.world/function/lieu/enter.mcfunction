# {lieu: string}; context: the player entering this location.
# The historic holder name is retained to preserve existing overlapping-location order.
scoreboard players add #tab_location_serial sgp.dummy 1
$scoreboard players operation @s sgp.lieu_$(lieu) = #tab_location_serial sgp.dummy
function #sgp.hooks:tab/location/dirty
