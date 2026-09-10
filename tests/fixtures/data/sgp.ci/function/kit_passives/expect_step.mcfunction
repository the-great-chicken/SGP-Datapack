#> sgp.ci:kit_passives/expect_step
# `{range: score range (step height * 10000)}`
#
# Read effective step height at fixed-point precision and compare it to the expected range.

execute store result score #ci.passive.step sgp.dummy run attribute @s minecraft:step_height get 10000
$assert score #ci.passive.step sgp.dummy matches $(range)
