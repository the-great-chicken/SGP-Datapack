#> sgp.mineurs:timer_overlap/all_four
# @dummy
# @environment sgp.ci:timer_overlap/all_four
#
# Four simultaneous events count down independently, and stopping the nearest reveals the next deadline.

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:bounty,duration:40}
function sgp.mineurs:common/timed_event/start {event:confinement,duration:10}
function sgp.mineurs:common/timed_event/start {event:frenzy,duration:30}
function sgp.mineurs:common/timed_event/start {event:smol,duration:20}
assert score #timed_events_active sgp.dummy matches 4
assert score #second sgp.timer matches 10
function sgp.mineurs:common/timed_event/tick
assert score #bounty_remaining sgp.timer matches 39
assert score #confinement_remaining sgp.timer matches 9
assert score #frenzy_remaining sgp.timer matches 29
assert score #smol_remaining sgp.timer matches 19
function sgp.mineurs:common/timed_event/stop {event:confinement}
assert score #timed_events_active sgp.dummy matches 3
assert score #second sgp.timer matches 19
