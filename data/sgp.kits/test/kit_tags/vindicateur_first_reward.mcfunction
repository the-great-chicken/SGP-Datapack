#> sgp.kits:kit_tags/vindicateur_first_reward
# @dummy
#
# Vindicateur earns the first totem after one kill, then every five kills.
# Repeated management passes must not reapply the starting progress.

tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 4
scoreboard players set @s sgp.kills_give_2 4
scoreboard players set @s sgp.kills_give_3 4
tag @s add sgp.vindicateur_voulu
scoreboard players set @s sgp.reset_tags 1
function sgp.kits:collection/vindicateur/specifics
function sgp.kits:kit_tags/management
function sgp.kits:kills_give/check
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:totem_of_undying",count:1}

function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_2 4
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:totem_of_undying",count:1}
function sgp.kits:kit_tags/management
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:totem_of_undying",count:2}
