#> sgp.mineurs:timed_events/independent_deadlines
# @dummy
#
# XP shows the nearest deadline; stopping it reveals the other event's remaining time, then clears XP after the last stop.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.minor_deadlines set value {}
tag @s add sgp.in_game
dummy TimerOutside spawn
experience set TimerOutside 42 levels
function sgp.mineurs:common/timed_event/start {event:"bounty",duration:10}
function sgp.mineurs:common/timed_event/start {event:"frenzy",duration:20}
execute store result storage sgp:data tests.minor_deadlines.initial int 1 run experience query @s levels
function sgp.ci:minor_events/advance {function:"sgp.misc:second",ticks:3}
execute store result storage sgp:data tests.minor_deadlines.elapsed int 1 run experience query @s levels
function sgp.mineurs:common/timed_event/stop {event:"bounty"}
execute store result storage sgp:data tests.minor_deadlines.next int 1 run experience query @s levels
function sgp.ci:minor_events/advance {function:"sgp.misc:second",ticks:2}
execute store result storage sgp:data tests.minor_deadlines.next_elapsed int 1 run experience query @s levels
function sgp.mineurs:common/timed_event/stop {event:"frenzy"}
function sgp.misc:second
execute store result storage sgp:data tests.minor_deadlines.finished int 1 run experience query @s levels
execute store result storage sgp:data tests.minor_deadlines.points int 1 run experience query @s points
execute store result storage sgp:data tests.minor_deadlines.outside int 1 run experience query TimerOutside levels
dummy TimerOutside leave
schedule clear sgp.misc:second

assert data storage sgp:data tests.minor_deadlines{initial:10,elapsed:7,next:17,next_elapsed:15,finished:0,points:0,outside:42}
assert score #timed_events_active sgp.dummy matches 0
data remove storage sgp:data tests.minor_deadlines
