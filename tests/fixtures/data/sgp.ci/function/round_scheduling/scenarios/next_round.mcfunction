#> sgp.ci:round_scheduling/scenarios/next_round

scoreboard players set #rounds sgp.dummy 0
scoreboard players set #pco_max_rounds sgp.dummy 3
function sgp.majeurs:common/rounds {event:pco,text:"CI event"}
assert score #rounds sgp.dummy matches 1
function sgp.ci:round_scheduling/expect_pending {event:pco,count:1}
function sgp.ci:round_scheduling/expect_pending {event:hide_and_seek,count:0}
function sgp.ci:round_scheduling/expect_pending {event:protect,count:0}
