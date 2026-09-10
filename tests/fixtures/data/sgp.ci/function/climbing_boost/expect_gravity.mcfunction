#> sgp.ci:climbing_boost/expect_gravity
# `{range: score range (gravity * 100000)}`
#
# Read effective gravity, including modifiers, and compare it at fixed-point precision.

execute store result score #ci.climb.gravity sgp.dummy run attribute @s minecraft:gravity get 100000
$assert score #ci.climb.gravity sgp.dummy matches $(range)
