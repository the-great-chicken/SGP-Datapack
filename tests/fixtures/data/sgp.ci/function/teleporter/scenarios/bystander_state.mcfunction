#> sgp.ci:teleporter/scenarios/bystander_state

function sgp.ci:teleporter/fixture
dummy PortalPeer spawn
gamemode creative PortalPeer
tp PortalPeer ~10.5 ~1 ~5.5
team join sgp.rouge PortalPeer
scoreboard players set PortalPeer sgp.teleporteur 23
scoreboard players set PortalPeer sgp.kit_id 4
item replace entity PortalPeer weapon.mainhand with diamond 7
function sgp.ci:teleporter/advance {ticks:60}
function sgp.ci:teleporter/expect_arrival {destination:a,yaw:90,pitch:15}
execute positioned ~10.5 ~1 ~5.5 run assert entity @a[name=PortalPeer,distance=..0.01,tag=!sgp.to_teleport,team=sgp.rouge,gamemode=creative]
assert score PortalPeer sgp.teleporteur matches 23
assert score PortalPeer sgp.kit_id matches 4
execute store result score #ci.portal.items sgp.dummy run clear PortalPeer diamond 0
assert score #ci.portal.items sgp.dummy matches 7
dummy PortalPeer leave
