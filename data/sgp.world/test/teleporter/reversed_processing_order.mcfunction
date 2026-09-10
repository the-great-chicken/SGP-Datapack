#> sgp.world:teleporter/reversed_processing_order
# @dummy
# @environment sgp.ci:teleporter/reversed_processing_order
#
# Reversing teleporter processing order does not change countdown speed or either player's destination.

function sgp.ci:teleporter/fixture
# Reverse the actual source list consumed by the production dispatcher.
data modify storage sgp:data tests.teleporter.first set from storage sgp:data tests.teleporter.sources[0]
data remove storage sgp:data tests.teleporter.sources[0]
data modify storage sgp:data tests.teleporter.sources append from storage sgp:data tests.teleporter.first
dummy PortalPeer spawn
gamemode creative PortalPeer
scoreboard players set PortalPeer sgp.teleporteur 0
tp PortalPeer ~14.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:59}
assert score @s sgp.teleporteur matches 59
assert score PortalPeer sgp.teleporteur matches 59
execute at @s run assert entity @e[tag=sgp.ci.portal_a,distance=..0.01,type=marker]
execute at PortalPeer run assert entity @e[tag=sgp.ci.portal_b,distance=..0.01,type=marker]
function sgp.ci:teleporter/advance {ticks:1}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
execute as PortalPeer run function sgp.ci:teleporter/expect_arrival {destination:b,yaw:-90,pitch:-30}
dummy PortalPeer leave
