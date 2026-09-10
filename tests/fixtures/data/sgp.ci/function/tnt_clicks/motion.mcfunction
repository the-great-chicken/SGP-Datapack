#> sgp.ci:tnt_clicks/motion
# `{target: a|b, x, y, z: score range (Motion * 10000)}`
#
# Check the selected TNT charge's three velocity components at fixed-point precision.

$assert entity @e[tag=sgp.ci.tnt_charge_$(target),type=tnt]
$execute store result score #ci.click.x sgp.dummy run data get entity @e[tag=sgp.ci.tnt_charge_$(target),limit=1,type=tnt] Motion[0] 10000
$execute store result score #ci.click.y sgp.dummy run data get entity @e[tag=sgp.ci.tnt_charge_$(target),limit=1,type=tnt] Motion[1] 10000
$execute store result score #ci.click.z sgp.dummy run data get entity @e[tag=sgp.ci.tnt_charge_$(target),limit=1,type=tnt] Motion[2] 10000
$assert score #ci.click.x sgp.dummy matches $(x)
$assert score #ci.click.y sgp.dummy matches $(y)
$assert score #ci.click.z sgp.dummy matches $(z)
