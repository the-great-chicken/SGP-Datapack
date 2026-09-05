#> sgp.mineurs:common/timed_event/stop
# `{event: string}`
#
# Unregister a timed minor event and display the next active deadline.

# _stop calls every event-specific stop, including events that are not active.
$execute unless score #$(event)_active sgp.dummy matches 1 run return 0

scoreboard players remove #timed_events_active sgp.dummy 1
$scoreboard players set #$(event)_active sgp.dummy 0

# Setting #second to zero lets sgp.misc:second perform its normal XP reset.
execute if score #timed_events_active sgp.dummy matches 0 \
    run return run scoreboard players set #second sgp.timer 0

# Otherwise jump to the remaining time of the next event due to finish.
function sgp.mineurs:common/timed_event/recompute
