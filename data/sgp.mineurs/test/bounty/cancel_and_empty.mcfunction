#> sgp.mineurs:bounty/cancel_and_empty
# @dummy
# @environment sgp.ci:bounty/cancel_and_empty
#
# Cancelling grants no survivor reward, and an empty eligible roster starts no timer.

function sgp.ci:minor_events/reset_timer
data modify storage sgp.ci:bounty cancel_and_empty set value {}
tag @s add sgp.in_game
function sgp.mineurs:bounty/start
function sgp.mineurs:bounty/stop
execute store success storage sgp.ci:bounty cancel_and_empty.claim byte 1 run trigger sgp.reward set 4
execute store success storage sgp.ci:bounty cancel_and_empty.glowing byte 1 if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:glowing":{}}}}
tag @s add sgp.peaceful
function sgp.mineurs:bounty/start
execute store result storage sgp.ci:bounty cancel_and_empty.wanted int 1 if entity @a[tag=sgp.wanted]
execute store result storage sgp.ci:bounty cancel_and_empty.active int 1 run scoreboard players get #timed_events_active sgp.dummy
execute store success storage sgp.ci:bounty cancel_and_empty.scheduled byte 1 run schedule clear sgp.mineurs:bounty/end
function sgp.mineurs:bounty/stop
schedule clear sgp.misc:second

assert data storage sgp.ci:bounty cancel_and_empty{claim:0b,glowing:0b,wanted:0,active:0,scheduled:0b}
data remove storage sgp.ci:bounty cancel_and_empty
