#> sgp.ci:experience_timer/scenarios/audience/2

function sgp.ci:experience_timer/expect_empty
execute as TimerPeer run function sgp.ci:experience_timer/expect_empty
execute as TimerOutside run function sgp.ci:experience_timer/expect_level {level:9}
execute store result score #ci.xp.outside sgp.dummy run experience query TimerOutside points
assert score #ci.xp.outside sgp.dummy matches 4
