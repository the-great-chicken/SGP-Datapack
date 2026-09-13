#> sgp.kits:kills_give/batched_kills
# @dummy

# Two kills before the reward check each earn arrows and complete one apple interval.
tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 2
scoreboard players set @s sgp.kills_give_2 2
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:1}
assert score @s sgp.kills_give_1 matches 0
assert score @s sgp.kills_give_2 matches 0
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:1}
