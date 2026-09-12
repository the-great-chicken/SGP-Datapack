#> sgp.majeurs:round_scheduling/event_specific_limit
# @dummy
# @environment sgp.ci:round_scheduling/event_specific_limit
#
# Round continuation uses the selected event's limit rather than another event's settings.

scoreboard players set #pco_max_rounds sgp.dummy 1
scoreboard players set #hide_and_seek_max_rounds sgp.dummy 4
scoreboard players set #protect_max_rounds sgp.dummy 2
scoreboard players set #rounds sgp.dummy 1
function sgp.majeurs:common/rounds {event:hide_and_seek,text:"CI event"}
function sgp.ci:round_scheduling/expect_pending {event:hide_and_seek,count:1}
scoreboard players set #rounds sgp.dummy 1
function sgp.majeurs:common/rounds {event:protect,text:"CI event"}
function sgp.ci:round_scheduling/expect_pending {event:protect,count:0}
