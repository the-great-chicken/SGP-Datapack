#> sgp.ci:experience_timer/expect_empty

function sgp.ci:experience_timer/expect_level {level:0}
execute store result score #ci.xp.points sgp.dummy run experience query @s points
assert score #ci.xp.points sgp.dummy matches 0
