#> sgp.kits:kills_give/batched_third_reward
# @dummy

tag @s add sgp.cancer
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 8
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:tnt_minecart",count:2}
assert score @s sgp.kills_give_3 matches 2
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:tnt_minecart",count:2}
scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:tnt_minecart",count:3}
assert score @s sgp.kills_give_3 matches 0
