#> sgp.majeurs:scheduler/run
# `{event}`
#
# Start the first round of an event.

scoreboard players set #rounds sgp.dummy 0
$function sgp.majeurs:$(event)/_start
