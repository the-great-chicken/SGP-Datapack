#> sgp.ci:teleporter/scenarios/independent_destinations

function sgp.ci:teleporter/fixture
dummy PortalPeer spawn
gamemode creative PortalPeer
scoreboard players set PortalPeer sgp.teleporteur 0
tp PortalPeer ~14.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:59}
assert score @s sgp.teleporteur matches 59
assert score PortalPeer sgp.teleporteur matches 59
function sgp.ci:teleporter/advance {ticks:1}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
execute as PortalPeer run function sgp.ci:teleporter/expect_arrival {destination:b,yaw:-90,pitch:-30}
dummy PortalPeer leave
