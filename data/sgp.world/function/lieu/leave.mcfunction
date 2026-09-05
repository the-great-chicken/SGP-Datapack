#> sgp.world:lieu/leave
# `{lieu: string}`
#
# Remove only the location that was actually left, then mark it as outside so
# entering it again can display its segment again.

$execute if score @s sgp.lieu_$(lieu) matches 2.. run function #sgp.hooks:tab/location/dirty
$execute if score @s sgp.lieu_$(lieu) matches 2.. run function sgp.misc:actionbar/location_clear {lieu:"$(lieu)"}
$scoreboard players set @s sgp.lieu_$(lieu) 1
