#> sgp.ci:climbing_boost/expect_gravity
# {range}: read effective gravity, including every modifier.

execute store result score #ci.climb.gravity sgp.dummy run attribute @s minecraft:gravity get 100000
$assert score #ci.climb.gravity sgp.dummy matches $(range)
