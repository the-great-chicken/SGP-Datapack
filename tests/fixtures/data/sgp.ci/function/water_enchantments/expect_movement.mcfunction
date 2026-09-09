#> sgp.ci:water_enchantments/expect_movement

# {speed, efficiency}: attribute values multiplied by 100000.
execute store result score #ci.water.speed sgp.dummy run attribute @s minecraft:movement_speed get 100000
execute store result score #ci.water.efficiency sgp.dummy run attribute @s minecraft:water_movement_efficiency get 100000
$assert score #ci.water.speed sgp.dummy matches $(speed)
$assert score #ci.water.efficiency sgp.dummy matches $(efficiency)
