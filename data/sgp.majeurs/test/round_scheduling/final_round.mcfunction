#> sgp.majeurs:round_scheduling/final_round
# @dummy
# @environment sgp.ci:round_scheduling/final_round
#
# Completing the configured final round does not queue another start.

scoreboard players set #rounds sgp.dummy 2
scoreboard players set #pco_max_rounds sgp.dummy 3
function sgp.majeurs:common/rounds {event:pco,text:"CI event"}
assert score #rounds sgp.dummy matches 3
function sgp.ci:round_scheduling/expect_pending {event:pco,count:0}
