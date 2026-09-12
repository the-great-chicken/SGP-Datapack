#> sgp.kits:cleave/kill_rewards
# @dummy
# @environment sgp.ci:cleave/kill_rewards

# A real Cleave sweep kills two players synchronously before a single reward check.
function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
attribute CleaveA minecraft:max_health base set 4
attribute CleaveB minecraft:max_health base set 4
await delay 1t
assert entity @a[name=CleaveA,nbt={Health:4.0f}]
assert entity @a[name=CleaveB,nbt={Health:4.0f}]
tp CleaveA ~10.5 ~1 ~13.5
tp CleaveB ~12.5 ~1 ~13.5
function sgp.ci:cleave/cast
assert score @s sgp.kills_give_1 matches 2
assert score @s sgp.kills_give_2 matches 2
function sgp.kits:kills_give/check
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:1}
assert score @s sgp.kills_give_1 matches 0
assert score @s sgp.kills_give_2 matches 0
