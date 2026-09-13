#> sgp.ci:honey_climbing/expect_gravity
# `{range: score range (gravity * 100000)}`
#
# Effective gravity is the observable movement setting; tolerate floating-point rounding.

execute store result score @s sgp.dummy run attribute @s minecraft:gravity get 100000
$assert score @s sgp.dummy matches $(range)
