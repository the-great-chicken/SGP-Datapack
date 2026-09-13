#> sgp.ci:water_enchantments/expect_movement
# `{speed, efficiency: score range (attribute * 100000)}`
#
# Read movement-speed and water-efficiency attributes at fixed-point precision.

execute store result score #ci.water.speed sgp.dummy run attribute @s minecraft:movement_speed get 100000
execute store result score #ci.water.efficiency sgp.dummy run attribute @s minecraft:water_movement_efficiency get 100000
$assert score #ci.water.speed sgp.dummy matches $(speed)
$assert score #ci.water.efficiency sgp.dummy matches $(efficiency)
