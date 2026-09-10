#> sgp.ci:experience_timer/expect_level
# `{level: nonnegative int}`
#
# Check the visible experience level used as the countdown display.

execute store result score #ci.xp.level sgp.dummy run experience query @s levels
$assert score #ci.xp.level sgp.dummy matches $(level)
