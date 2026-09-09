#> sgp.ci:timer_overlap/scenarios/inactive_stop

tag @s add sgp.in_game
function sgp.mineurs:common/timed_event/start {event:frenzy,duration:40}
function sgp.mineurs:common/timed_event/stop {event:bounty}
function sgp.mineurs:common/timed_event/stop {event:bounty}
assert score #timed_events_active sgp.dummy matches 1
assert score #second sgp.timer matches 40
