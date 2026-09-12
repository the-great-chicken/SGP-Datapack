#> sgp.ci:tnt_batting/expect_motion
# `{x, y, z: score range (Motion * 10000)}`
#
# Read TNT velocity at fixed-point precision and compare all three components to expected ranges.

execute store result score #ci.bat.x sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[0] 10000
execute store result score #ci.bat.y sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[1] 10000
execute store result score #ci.bat.z sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[2] 10000
$assert score #ci.bat.x sgp.dummy matches $(x)
$assert score #ci.bat.y sgp.dummy matches $(y)
$assert score #ci.bat.z sgp.dummy matches $(z)
