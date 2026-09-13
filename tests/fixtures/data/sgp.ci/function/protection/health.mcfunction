#> sgp.ci:protection/health
# `{range: score range (Health * 1000)}`
#
# Read current health at fixed-point precision and compare it to the expected range.

execute store result score #ci.protection.health sgp.dummy run data get entity @s Health 1000
$assert score #ci.protection.health sgp.dummy matches $(range)
