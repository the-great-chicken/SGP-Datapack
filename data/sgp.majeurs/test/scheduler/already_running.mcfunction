#> sgp.majeurs:scheduler/already_running
# @dummy
# @environment sgp.ci:major_schedule
#
# Requests for any event, including the active one, must preserve the current round and participants when an event is already active.

tag @s add sgp.major_participant
tag @s add sgp.in_game
scoreboard players set #rounds sgp.dummy 3

team join sgp.rouge @s
function sgp.majeurs:scheduler/run {event:pco}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:hide_and_seek}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:protect}
assert score #rounds sgp.dummy matches 3
assert entity @s[team=sgp.rouge,tag=sgp.major_participant]

team join sgp.Oie @s
function sgp.majeurs:scheduler/run {event:pco}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:hide_and_seek}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:protect}
assert score #rounds sgp.dummy matches 3
assert entity @s[team=sgp.Oie,tag=sgp.major_participant]

team join sgp.hider @s
function sgp.majeurs:scheduler/run {event:pco}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:hide_and_seek}
assert score #rounds sgp.dummy matches 3
function sgp.majeurs:scheduler/run {event:protect}
assert score #rounds sgp.dummy matches 3
assert entity @s[team=sgp.hider,tag=sgp.major_participant]
