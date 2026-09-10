#> sgp.ci:teleporter/expect_arrival
# `{destination: a|b, yaw, pitch: degrees}`
#
# Require arrival at the selected destination with its expected facing and a completed teleport countdown.

$execute at @s run assert entity @e[tag=sgp.ci.destination_$(destination),distance=..0.01,type=marker]
execute store result score #ci.portal.yaw sgp.dummy run data get entity @s Rotation[0]
execute store result score #ci.portal.pitch sgp.dummy run data get entity @s Rotation[1]
$assert score #ci.portal.yaw sgp.dummy matches $(yaw)
$assert score #ci.portal.pitch sgp.dummy matches $(pitch)
assert not entity @s[tag=sgp.to_teleport]
assert score @s sgp.teleporteur matches 0
