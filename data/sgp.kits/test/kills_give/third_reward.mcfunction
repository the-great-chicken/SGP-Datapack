#> sgp.kits:kills_give/third_reward
# @dummy
#
# Cancer's minecart is earned every three kills, once per completed interval.

tag @s add sgp.cancer
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 2
function sgp.kits:kills_give/check
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}

scoreboard players add @s sgp.kills_give_3 2
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:1}
scoreboard players add @s sgp.kills_give_3 1
function sgp.kits:kills_give/check
function sgp.ci:kills_give/assert_count {item:"minecraft:tnt_minecart",count:2}
