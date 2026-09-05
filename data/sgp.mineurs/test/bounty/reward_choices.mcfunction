#> sgp.mineurs:bounty/reward_choices
# @dummy
#
# A reward ticket is consumed once; duplicate or invalid choices allow choosing another reward.

data modify storage sgp:data tests.bounty_choices set value {}
attribute @s minecraft:max_health base set 20
function sgp.mineurs:bounty/reward/message
trigger sgp.reward set 4
function sgp.mineurs:bounty/reward/trigger
execute store success storage sgp:data tests.bounty_choices.reuse byte 1 run trigger sgp.reward set 4
function sgp.mineurs:bounty/reward/message
trigger sgp.reward set 4
function sgp.mineurs:bounty/reward/trigger
execute store success storage sgp:data tests.bounty_choices.retry_duplicate byte 1 run trigger sgp.reward set 3
function sgp.mineurs:bounty/reward/trigger
execute store result storage sgp:data tests.bounty_choices.max_health int 1 run attribute @s minecraft:max_health get

function sgp.mineurs:bounty/reward/message
trigger sgp.reward set 99
function sgp.mineurs:bounty/reward/trigger
execute store success storage sgp:data tests.bounty_choices.retry_invalid byte 1 run trigger sgp.reward set 1
function sgp.mineurs:bounty/reward/trigger
execute store success storage sgp:data tests.bounty_choices.strength byte 1 if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:strength":{amplifier:0,duration:2400}}}}

assert data storage sgp:data tests.bounty_choices{reuse:0b,retry_duplicate:1b,max_health:26,retry_invalid:1b,strength:1b}
function sgp.ci:kills_give/assert_count {item:"minecraft:totem_of_undying",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:1}
assert score @s sgp.reward matches 0
data remove storage sgp:data tests.bounty_choices
