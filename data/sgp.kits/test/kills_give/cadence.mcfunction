#> sgp.kits:kills_give/cadence
# @dummy
#
# Combattant receives arrows every kill and an apple every two kills.
# Rechecking without another kill must not duplicate either reward.

tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 0
function sgp.kits:kills_give/check
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:3}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:0}
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:3}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:0}

scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:6}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:6}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}

scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:9}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}

scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:12}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:2}
