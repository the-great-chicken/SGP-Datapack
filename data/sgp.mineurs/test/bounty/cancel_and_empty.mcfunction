#> sgp.mineurs:bounty/cancel_and_empty
# @dummy
#
# Cancelling grants no survivor reward, and an empty eligible roster starts no timer.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.bounty_cancel set value {}
tag @s add sgp.in_game
function sgp.mineurs:bounty/start
function sgp.mineurs:bounty/stop
execute store success storage sgp:data tests.bounty_cancel.claim byte 1 run trigger sgp.reward set 4
execute store success storage sgp:data tests.bounty_cancel.glowing byte 1 if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:glowing":{}}}}
tag @s add sgp.peaceful
function sgp.mineurs:bounty/start
execute store result storage sgp:data tests.bounty_cancel.wanted int 1 if entity @a[tag=sgp.wanted]
execute store result storage sgp:data tests.bounty_cancel.active int 1 run scoreboard players get #timed_events_active sgp.dummy
execute store success storage sgp:data tests.bounty_cancel.scheduled byte 1 run schedule clear sgp.mineurs:bounty/end
function sgp.mineurs:bounty/stop
schedule clear sgp.misc:second

assert data storage sgp:data tests.bounty_cancel{claim:0b,glowing:0b,wanted:0,active:0,scheduled:0b}
data remove storage sgp:data tests.bounty_cancel
