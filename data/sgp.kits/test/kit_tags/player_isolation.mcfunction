#> sgp.kits:kit_tags/player_isolation
# @dummy
#
# Switching one player to Peaceful neither rewards them nor resets another player's progress.

data modify storage sgp:data tests.kit_switch_players set value {}
tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 1
scoreboard players set @s sgp.kills_give_2 1
scoreboard players set @s sgp.kills_give_3 1
tag @s add sgp.peaceful_voulu
scoreboard players set @s sgp.reset_tags 1
dummy KitSwitchOther spawn
tag KitSwitchOther add sgp.combattant
scoreboard players set KitSwitchOther sgp.reset_tags 0
scoreboard players set KitSwitchOther sgp.kills_give_1 0
scoreboard players set KitSwitchOther sgp.kills_give_2 1
scoreboard players set KitSwitchOther sgp.kills_give_3 0

function sgp.kits:kit_tags/management
function sgp.kits:kills_give/check
execute store result storage sgp:data tests.kit_switch_players.before int 1 run clear KitSwitchOther minecraft:golden_apple 0
scoreboard players add KitSwitchOther sgp.kills_give_1 1
scoreboard players add KitSwitchOther sgp.kills_give_2 1
scoreboard players add @s sgp.kills_give_1 1
scoreboard players add @s sgp.kills_give_2 1
function sgp.kits:kit_tags/management
function sgp.kits:kills_give/check
execute store result storage sgp:data tests.kit_switch_players.apples int 1 run clear KitSwitchOther minecraft:golden_apple 0
execute store result storage sgp:data tests.kit_switch_players.arrows int 1 run clear KitSwitchOther minecraft:arrow 0
dummy KitSwitchOther leave

assert data storage sgp:data tests.kit_switch_players{before:0,apples:1,arrows:3}
assert entity @s[tag=sgp.peaceful]
assert not entity @s[nbt={Inventory:[{}]}]
data remove storage sgp:data tests.kit_switch_players
