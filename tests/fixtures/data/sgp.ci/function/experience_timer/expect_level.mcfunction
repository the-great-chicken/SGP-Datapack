#> sgp.ci:experience_timer/expect_level

# {level}: the player's visible countdown.
execute store result score #ci.xp.level sgp.dummy run experience query @s levels
$assert score #ci.xp.level sgp.dummy matches $(level)
