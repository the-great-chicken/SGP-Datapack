#> sgp.kits:kills_give/simultaneous_rewards
# @dummy
#
# All three Cancer reward tiers can pay out together, including the items outside the shared helper.

tag @s add sgp.cancer
scoreboard players set @s sgp.kills_give_1 1
scoreboard players set @s sgp.kills_give_2 2
scoreboard players set @s sgp.kills_give_3 3
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tipped_arrow",count:2}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:splash_potion",count:2}
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}

function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tipped_arrow",count:2}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:splash_potion",count:2}
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}
