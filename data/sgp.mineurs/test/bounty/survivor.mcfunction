#> sgp.mineurs:bounty/survivor
# @dummy
# @environment sgp.ci:bounty/survivor
#
# Only eligible players become wanted; surviving expiry clears the mark and grants a claimable reward.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.bounty_survivor set value {}
tag @s add sgp.in_game
dummy BountyPeaceful spawn
tag BountyPeaceful add sgp.in_game
tag BountyPeaceful add sgp.peaceful
dummy BountyOutside spawn
function sgp.mineurs:bounty/start
execute store success storage sgp:data tests.bounty_survivor.wanted byte 1 if entity @s[tag=sgp.wanted]
execute store success storage sgp:data tests.bounty_survivor.glowing byte 1 if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:glowing":{}}}}
execute store result storage sgp:data tests.bounty_survivor.peaceful int 1 if entity @a[name=BountyPeaceful,tag=sgp.wanted]
execute store result storage sgp:data tests.bounty_survivor.outside int 1 if entity @a[name=BountyOutside,tag=sgp.wanted]
function sgp.mineurs:bounty/end
execute store success storage sgp:data tests.bounty_survivor.glowing_after byte 1 if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:glowing":{}}}}
execute store success storage sgp:data tests.bounty_survivor.claim byte 1 run trigger sgp.reward set 4
function sgp.mineurs:bounty/reward/trigger
dummy BountyPeaceful leave
dummy BountyOutside leave
schedule clear sgp.misc:second

assert data storage sgp:data tests.bounty_survivor{wanted:1b,glowing:1b,peaceful:0,outside:0,glowing_after:0b,claim:1b}
assert not entity @s[tag=sgp.wanted]
assert score #timed_events_active sgp.dummy matches 0
function sgp.ci:kills_give/assert_count {item:"minecraft:totem_of_undying",count:1}
function sgp.ci:kills_give/assert_count {item:"minecraft:enchanted_golden_apple",count:1}
data remove storage sgp:data tests.bounty_survivor
