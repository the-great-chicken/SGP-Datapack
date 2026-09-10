#> sgp.world:teleporter/cancel_and_restart
# @dummy
# @environment sgp.ci:teleporter/cancel_and_restart
#
# Leaving before the final update cancels the teleport; returning starts a fresh countdown.

function sgp.ci:teleporter/fixture
function sgp.ci:teleporter/advance {ticks:59}
tp @s ~4 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:1}
assert not entity @s[tag=sgp.to_teleport]
assert score @s sgp.teleporteur matches 0
execute positioned ~4 ~1 ~2.5 run assert entity @s[distance=..0.01]
tp @s ~2.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:1}
assert score @s sgp.teleporteur matches 1
function sgp.ci:teleporter/advance {ticks:59}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
