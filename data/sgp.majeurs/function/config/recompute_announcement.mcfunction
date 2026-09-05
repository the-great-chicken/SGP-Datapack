#> sgp.majeurs:config/recompute_announcement
# `{event}`
#
# Derive the two-minute announcement time from an event's configured start time.

$scoreboard players operation #$(event)_announcement_hour sgp.dummy = #$(event)_hour sgp.dummy
$scoreboard players operation #$(event)_announcement_minute sgp.dummy = #$(event)_minute sgp.dummy
$scoreboard players remove #$(event)_announcement_minute sgp.dummy 2

$execute if score #$(event)_announcement_minute sgp.dummy matches ..-1 run scoreboard players add #$(event)_announcement_minute sgp.dummy 60
$execute if score #$(event)_announcement_minute sgp.dummy matches 58..59 run scoreboard players remove #$(event)_announcement_hour sgp.dummy 1
$execute if score #$(event)_announcement_hour sgp.dummy matches ..-1 run scoreboard players set #$(event)_announcement_hour sgp.dummy 23
