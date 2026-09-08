#> sgp.ci:perfect_accuracy/check
# {x, y, z}
# Check each velocity component independently, allowing only the calculation's rounding error.

execute store result score #ci.accuracy.x sgp.dummy run data get entity @s Motion[0] 10000
execute store result score #ci.accuracy.y sgp.dummy run data get entity @s Motion[1] 10000
execute store result score #ci.accuracy.z sgp.dummy run data get entity @s Motion[2] 10000
$assert score #ci.accuracy.x sgp.dummy matches $(x)
$assert score #ci.accuracy.y sgp.dummy matches $(y)
$assert score #ci.accuracy.z sgp.dummy matches $(z)
