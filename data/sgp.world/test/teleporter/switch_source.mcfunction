#> sgp.world:teleporter/switch_source
# @dummy
# @environment sgp.ci:teleporter/switch_source
#
# Moving to another teleporter starts its own full wait and changes the destination.

function sgp.ci:teleporter/fixture
function sgp.ci:teleporter/advance {ticks:30}
tp @s ~14.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:1}
assert score @s sgp.teleporteur matches 1
function sgp.ci:teleporter/advance {ticks:58}
execute at @s run assert entity @e[tag=sgp.ci.portal_b,distance=..0.01,type=marker]
function sgp.ci:teleporter/advance {ticks:1}
function sgp.ci:teleporter/expect_arrival {destination:b,yaw:-90,pitch:-30}
