#> sgp.mineurs:bounty/reset_rewards
# @dummy
#
# Reset removes the bounty health bonus, preserves unrelated modifiers, and allows earning that reward again.

data modify storage sgp:data tests.bounty_reset set value {}
attribute @s minecraft:max_health base set 20
attribute @s minecraft:max_health modifier add sgp:test_health 4 add_value
function sgp.mineurs:bounty/reward/message
trigger sgp.reward set 3
function sgp.mineurs:bounty/reward/trigger
execute store result storage sgp:data tests.bounty_reset.rewarded int 1 run attribute @s minecraft:max_health get
function sgp.mineurs:bounty/reward/reset
execute store result storage sgp:data tests.bounty_reset.reset int 1 run attribute @s minecraft:max_health get
function sgp.mineurs:bounty/reward/message
trigger sgp.reward set 3
function sgp.mineurs:bounty/reward/trigger
execute store result storage sgp:data tests.bounty_reset.earned_again int 1 run attribute @s minecraft:max_health get

assert data storage sgp:data tests.bounty_reset{rewarded:30,reset:24,earned_again:30}
data remove storage sgp:data tests.bounty_reset
