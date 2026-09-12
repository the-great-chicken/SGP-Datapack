#> sgp.kits:kills_give/batched_remainder
# @dummy

# One saved kill plus six new kills crosses the apple threshold three times and retains one kill.
tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 6
scoreboard players set @s sgp.kills_give_2 7
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:18}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
assert score @s sgp.kills_give_1 matches 0
assert score @s sgp.kills_give_2 matches 1
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:21}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:4}
assert score @s sgp.kills_give_2 matches 0
