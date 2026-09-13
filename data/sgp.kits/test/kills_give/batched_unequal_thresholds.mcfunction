#> sgp.kits:kills_give/batched_unequal_thresholds
# @dummy

# Vindicateur's slot numbers are not its thresholds: three and five kills.
tag @s add sgp.vindicateur
scoreboard players set @s sgp.kills_give_1 8
scoreboard players set @s sgp.kills_give_2 12
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:2}
function sgp.ci:inventory/expect_count {item:"minecraft:totem_of_undying",count:2}
assert score @s sgp.kills_give_1 matches 2
assert score @s sgp.kills_give_2 matches 2
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:2}
function sgp.ci:inventory/expect_count {item:"minecraft:totem_of_undying",count:2}
