#> sgp.mineurs:common/change_event_if_same
# `{nbr: int}`
#
# Skip events from the previous round and earlier picks in this round.

$execute if score #random_event_roll_$(nbr) sgp.dummy matches 8.. \
    run scoreboard players set #random_event_roll_$(nbr) sgp.dummy 1

$execute if score $(nbr) sgp.dummy matches 2.. \
    if score #random_event_roll_$(nbr) sgp.dummy = #random_event_roll_1 sgp.dummy \
        run return run function sgp.mineurs:common/next_event {nbr:$(nbr)}

$execute if score $(nbr) sgp.dummy matches 3 \
    if score #random_event_roll_$(nbr) sgp.dummy = #random_event_roll_2 sgp.dummy \
        run return run function sgp.mineurs:common/next_event {nbr:$(nbr)}

$execute if score #random_event_roll_$(nbr) sgp.dummy = #last_event_1 sgp.dummy \
    run return run function sgp.mineurs:common/next_event {nbr:$(nbr)}

$execute if score #last_nbr_events sgp.dummy matches 2.. \
    if score #random_event_roll_$(nbr) sgp.dummy = #last_event_2 sgp.dummy \
        run return run function sgp.mineurs:common/next_event {nbr:$(nbr)}

$execute if score #last_nbr_events sgp.dummy matches 3.. \
    if score #random_event_roll_$(nbr) sgp.dummy = #last_event_3 sgp.dummy \
        run return run function sgp.mineurs:common/next_event {nbr:$(nbr)}
