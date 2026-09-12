#> sgp.kits:kills_give/batched_roi
# @dummy

tag @s add sgp.roi
scoreboard players set @s sgp.kills_give_1 3
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
assert score @s sgp.kills_give_1 matches 0
assert entity @s[nbt={active_effects:[{id:"minecraft:regeneration",amplifier:3b}]}]
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
