#> sgp.world:teleporter/countdown
# @dummy
# @environment sgp.ci:teleporter/countdown
#
# A full sixty updates are required, and arrival uses the configured position and facing.

function sgp.ci:teleporter/fixture
function sgp.ci:teleporter/advance {ticks:59}
execute at @s run assert entity @e[tag=sgp.ci.portal_a,distance=..0.01,type=marker]
assert score @s sgp.teleporteur matches 59
function sgp.ci:teleporter/advance {ticks:1}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
function sgp.ci:teleporter/advance {ticks:5}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
