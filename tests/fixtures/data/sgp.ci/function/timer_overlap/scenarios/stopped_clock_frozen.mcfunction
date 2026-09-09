#> sgp.ci:timer_overlap/scenarios/stopped_clock_frozen

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:bounty,duration:20}
function sgp.mineurs:common/timed_event/start {event:frenzy,duration:40}
function sgp.mineurs:common/timed_event/stop {event:bounty}
function sgp.mineurs:common/timed_event/tick
assert score #bounty_remaining sgp.timer matches 20
assert score #frenzy_remaining sgp.timer matches 39
function sgp.mineurs:common/timed_event/recompute
assert score #timed_events_active sgp.dummy matches 1
assert score #second sgp.timer matches 39
