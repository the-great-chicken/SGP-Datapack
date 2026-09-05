#> sgp.kits:kit_tags/switch_resets_rewards
# @dummy
#
# A queued switch from Archer to Cancer discards old reward progress and stops Archer rewards.
# Later management passes must preserve progress earned with the new kit.

tag @s add sgp.archer
scoreboard players set @s sgp.kills_give_1 1
scoreboard players set @s sgp.kills_give_2 1
scoreboard players set @s sgp.kills_give_3 2
tag @s add sgp.cancer_voulu
scoreboard players set @s sgp.reset_tags 1
function sgp.kits:kit_tags/management
function sgp.kits:kills_give/check
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tipped_arrow",count:2}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:0}
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:0}

function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tipped_arrow",count:4}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:0}

function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tipped_arrow",count:6}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}
