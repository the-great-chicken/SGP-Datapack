#> sgp.mineurs:scheduler/timer_cadence
# @environment sgp.ci:minor_scheduler/timer_cadence
#
# The scheduler advances one logical second every ten timer invocations, including from a partially elapsed second.

scoreboard players set #random_event_timer_roll sgp.dummy 1000
scoreboard players set #random_event_timer_roll_minus_60 sgp.dummy 940
scoreboard players set #events_mineurs sgp.timer 0
scoreboard players set #events_mineurs_seconds sgp.timer 0

function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
assert score #events_mineurs sgp.timer matches 9
assert score #events_mineurs_seconds sgp.timer matches 0

function sgp.mineurs:common/timer
assert score #events_mineurs sgp.timer matches 0
assert score #events_mineurs_seconds sgp.timer matches 1

scoreboard players set #events_mineurs sgp.timer 7
scoreboard players set #events_mineurs_seconds sgp.timer 41
function sgp.mineurs:common/timer
function sgp.mineurs:common/timer
assert score #events_mineurs sgp.timer matches 9
assert score #events_mineurs_seconds sgp.timer matches 41
function sgp.mineurs:common/timer
assert score #events_mineurs sgp.timer matches 0
assert score #events_mineurs_seconds sgp.timer matches 42
