#> sgp.kits:kills_give/player_isolation
# @dummy
#
# Each player receives their own kit's rewards; another player's kill does not reward an idle teammate.
# A player without a kit receives nothing even with pending kill counters.

data modify storage sgp:data tests.kill_rewards_players set value {}
tag @s add sgp.combattant
scoreboard players set @s sgp.kills_give_1 1
scoreboard players set @s sgp.kills_give_2 1
scoreboard players set @s sgp.kills_give_3 1
dummy RewardPyro spawn
dummy RewardIdle spawn
dummy RewardNoKit spawn
tag RewardPyro add sgp.pyromane
tag RewardIdle add sgp.combattant
scoreboard players set RewardPyro sgp.kills_give_1 1
scoreboard players set RewardPyro sgp.kills_give_2 1
scoreboard players set RewardPyro sgp.kills_give_3 1
scoreboard players set RewardIdle sgp.kills_give_1 0
scoreboard players set RewardIdle sgp.kills_give_2 0
scoreboard players set RewardIdle sgp.kills_give_3 0
scoreboard players set RewardNoKit sgp.kills_give_1 5
scoreboard players set RewardNoKit sgp.kills_give_2 5
scoreboard players set RewardNoKit sgp.kills_give_3 5

function sgp.kits:kills_give/check
execute store result storage sgp:data tests.kill_rewards_players.pyro_arrows int 1 run clear RewardPyro minecraft:arrow 0
execute store result storage sgp:data tests.kill_rewards_players.pyro_explosives int 1 run clear RewardPyro minecraft:strider_spawn_egg 0
execute store result storage sgp:data tests.kill_rewards_players.pyro_apples int 1 run clear RewardPyro minecraft:golden_apple 0
data modify storage sgp:data tests.kill_rewards_players.idle set from entity RewardIdle Inventory
data modify storage sgp:data tests.kill_rewards_players.no_kit set from entity RewardNoKit Inventory
dummy RewardPyro leave
dummy RewardIdle leave
dummy RewardNoKit leave

assert data storage sgp:data tests.kill_rewards_players{pyro_arrows:2,pyro_explosives:2,pyro_apples:0,idle:[],no_kit:[]}
function sgp.ci:kills_give/assert_count {item:"minecraft:arrow",count:3}
function sgp.ci:kills_give/assert_count {item:"minecraft:golden_apple",count:0}
function sgp.ci:kills_give/assert_count {item:"minecraft:strider_spawn_egg",count:0}
data remove storage sgp:data tests.kill_rewards_players
