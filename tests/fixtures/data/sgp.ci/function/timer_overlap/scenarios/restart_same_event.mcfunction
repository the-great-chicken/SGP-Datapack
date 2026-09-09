#> sgp.ci:timer_overlap/scenarios/restart_same_event

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:bounty,duration:20}
function sgp.mineurs:common/timed_event/start {event:bounty,duration:50}
assert score #timed_events_active sgp.dummy matches 1
assert score #second sgp.timer matches 50
assert score #bounty_remaining sgp.timer matches 50
