#> sgp.mineurs:common/timed_event/start
# `{event: string, duration: int}`
#
# Register a timed minor event and its independent remaining time.

scoreboard players add #timed_events_active sgp.dummy 1
$scoreboard players set #$(event)_active sgp.dummy 1
$scoreboard players set #$(event)_remaining sgp.timer $(duration)

# A newly registered event may become the next one due to finish.
function sgp.mineurs:common/timed_event/recompute

# The existing second timer owns the clock and XP cleanup.
execute if score #timed_events_active sgp.dummy matches 1 run schedule function sgp.misc:second 1s replace
