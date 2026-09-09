#> sgp.ci:teleporter/scenarios/return_after_arrival

function sgp.ci:teleporter/fixture
function sgp.ci:teleporter/advance {ticks:60}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
tp @s ~2.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:59}
assert score @s sgp.teleporteur matches 59
execute at @s run assert entity @e[tag=sgp.ci.portal_a,distance=..0.01,type=marker]
function sgp.ci:teleporter/advance {ticks:1}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
