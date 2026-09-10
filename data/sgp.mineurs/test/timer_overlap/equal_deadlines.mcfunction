#> sgp.mineurs:timer_overlap/equal_deadlines
# @dummy
# @environment sgp.ci:timer_overlap/equal_deadlines
#
# Equal deadlines remain valid when one event stops; stopping the last event ends the shared display.

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:bounty,duration:20}
function sgp.mineurs:common/timed_event/start {event:smol,duration:20}
assert score #timed_events_active sgp.dummy matches 2
assert score #second sgp.timer matches 20
function sgp.mineurs:common/timed_event/stop {event:bounty}
assert score #timed_events_active sgp.dummy matches 1
assert score #second sgp.timer matches 20
function sgp.mineurs:common/timed_event/stop {event:smol}
assert score #timed_events_active sgp.dummy matches 0
assert score #second sgp.timer matches 0
