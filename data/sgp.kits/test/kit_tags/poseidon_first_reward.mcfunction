#> sgp.kits:kit_tags/poseidon_first_reward
# @dummy
#
# Poseidon earns the first enchanted apple after two kills, then every five kills.
# The kit-specific starting progress is applied once, after old progress is reset.

tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 4
scoreboard players set @s sgp.kills_give_2 4
scoreboard players set @s sgp.kills_give_3 4
tag @s add sgp.poseidon_voulu
scoreboard players set @s sgp.reset_tags 1
function sgp.kits:collection/poseidon/specifics
function sgp.kits:kit_tags/management
function sgp.kits:kills_give/check
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:0}
function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:1}

function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_2 4
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:1}
function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:2}
