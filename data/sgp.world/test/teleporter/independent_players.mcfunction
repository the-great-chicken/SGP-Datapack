#> sgp.world:teleporter/independent_players
# @dummy
# @environment sgp.ci:teleporter/independent_players
#
# Players arriving at different times keep independent countdowns on the same teleporter.

function sgp.ci:teleporter/fixture
function sgp.ci:teleporter/advance {ticks:20}
dummy PortalPeer spawn
gamemode creative PortalPeer
scoreboard players set PortalPeer sgp.teleporteur 0
tp PortalPeer ~2.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:40}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
assert score PortalPeer sgp.teleporteur matches 40
execute at PortalPeer run assert entity @e[tag=sgp.ci.portal_a,distance=..0.01,type=marker]
function sgp.ci:teleporter/advance {ticks:20}
execute as PortalPeer run function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
dummy PortalPeer leave
