#> sgp.ci:major_schedule/save
# Save one event's configuration for batch teardown.

$execute store result storage sgp.ci:major_schedule previous.$(event).hour int 1 run scoreboard players get #$(event)_hour sgp.dummy
$execute store result storage sgp.ci:major_schedule previous.$(event).minute int 1 run scoreboard players get #$(event)_minute sgp.dummy
$execute store result storage sgp.ci:major_schedule previous.$(event).rounds int 1 run scoreboard players get #$(event)_max_rounds sgp.dummy
$execute store result storage sgp.ci:major_schedule previous.$(event).announcement_hour int 1 run scoreboard players get #$(event)_announcement_hour sgp.dummy
$execute store result storage sgp.ci:major_schedule previous.$(event).announcement_minute int 1 run scoreboard players get #$(event)_announcement_minute sgp.dummy
