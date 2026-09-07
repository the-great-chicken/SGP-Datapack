#> sgp.majeurs:scheduler/run
# `{event}`
#
# Start the first round without disturbing an event already in progress.

execute if entity @a[predicate=sgp.majeurs:event_in_progress] run return 0
scoreboard players set #rounds sgp.dummy 0
$function sgp.majeurs:$(event)/_start
