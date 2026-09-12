#> sgp.majeurs:round_scheduling/single_round
# @dummy
# @environment sgp.ci:round_scheduling/single_round
#
# An event configured for one round stops after its first completion.

scoreboard players set #rounds sgp.dummy 0
scoreboard players set #hide_and_seek_max_rounds sgp.dummy 1
function sgp.majeurs:common/rounds {event:hide_and_seek,text:"CI event"}
assert score #rounds sgp.dummy matches 1
function sgp.ci:round_scheduling/expect_pending {event:hide_and_seek,count:0}
