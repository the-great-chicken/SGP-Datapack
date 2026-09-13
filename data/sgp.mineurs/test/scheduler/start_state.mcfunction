#> sgp.mineurs:scheduler/start_state
# @environment sgp.ci:minor_scheduler/start_state
#
# Starting the minor-event scheduler resets elapsed time and rolls a valid event/lootdrop delay pair.

scoreboard players set #events_mineurs_actifs sgp.dummy 0
scoreboard players set #events_mineurs sgp.timer 7
scoreboard players set #events_mineurs_seconds sgp.timer 91
function sgp.mineurs:_start

assert score #events_mineurs_actifs sgp.dummy matches 1
assert score #events_mineurs sgp.timer matches 0
assert score #events_mineurs_seconds sgp.timer matches 0
assert score #random_event_timer_roll sgp.dummy matches 200..300
assert score #random_event_timer_roll_minus_60 sgp.dummy matches 140..240
scoreboard players operation #ci.minor.delay sgp.dummy = #random_event_timer_roll sgp.dummy
scoreboard players operation #ci.minor.delay sgp.dummy -= #random_event_timer_roll_minus_60 sgp.dummy
assert score #ci.minor.delay sgp.dummy matches 60
