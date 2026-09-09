#> sgp.ci:teleporter/scenarios/cancel_shared_pad

function sgp.ci:teleporter/fixture
dummy PortalPeer spawn
gamemode creative PortalPeer
scoreboard players set PortalPeer sgp.teleporteur 0
tp PortalPeer ~2.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:59}
tp @s ~5.5 ~1 ~2.5
function sgp.ci:teleporter/advance {ticks:1}
execute positioned ~5.5 ~1 ~2.5 run assert entity @s[distance=..0.01]
assert not entity @s[tag=sgp.to_teleport]
assert score @s sgp.teleporteur matches 0
execute as PortalPeer run function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
dummy PortalPeer leave
