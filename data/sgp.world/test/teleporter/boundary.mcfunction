#> sgp.world:teleporter/boundary
# @dummy
# @environment sgp.ci:teleporter/boundary
#
# The one-block boundary is included, while a player just beyond it cannot begin teleporting.

function sgp.ci:teleporter/fixture
tp @s ~3.51 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:3}
assert not entity @s[tag=sgp.to_teleport]
assert score @s sgp.teleporteur matches 0
tp @s ~3.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:60}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
