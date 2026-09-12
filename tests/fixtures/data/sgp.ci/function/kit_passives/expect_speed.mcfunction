#> sgp.ci:kit_passives/expect_speed
# `{range: score range (movement speed * 10000)}`
#
# Read effective movement speed at fixed-point precision and compare it to the expected range.

execute store result score #ci.passive.speed sgp.dummy run attribute @s minecraft:movement_speed get 10000
$assert score #ci.passive.speed sgp.dummy matches $(range)
