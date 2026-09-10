#> sgp.mineurs:timer_overlap/restart_changes_next
# @dummy
# @environment sgp.ci:timer_overlap/restart_changes_next
#
# Extending the nearest deadline reveals the next active deadline.

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:bounty,duration:10}
function sgp.mineurs:common/timed_event/start {event:smol,duration:30}
function sgp.mineurs:common/timed_event/start {event:bounty,duration:50}
assert score #timed_events_active sgp.dummy matches 2
assert score #second sgp.timer matches 30
