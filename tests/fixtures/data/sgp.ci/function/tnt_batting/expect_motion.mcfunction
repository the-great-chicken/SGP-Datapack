#> sgp.ci:tnt_batting/expect_motion

# {x,y,z}: expected velocity multiplied by 10000, allowing milliblock rounding.
execute store result score #ci.bat.x sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[0] 10000
execute store result score #ci.bat.y sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[1] 10000
execute store result score #ci.bat.z sgp.dummy run data get entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] Motion[2] 10000
$assert score #ci.bat.x sgp.dummy matches $(x)
$assert score #ci.bat.y sgp.dummy matches $(y)
$assert score #ci.bat.z sgp.dummy matches $(z)
