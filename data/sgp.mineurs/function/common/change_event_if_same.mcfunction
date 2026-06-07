#> sgp.mineurs:common/change_event_if_same
# `{nbr: int}`
#
# If the selected event is one that already ran in the last round, choose another
# Also prevents the same event to be chosen multiple times in the same round

$execute if score 2 sgp.dummy matches $(nbr) \
    if score #random_event_roll_2 sgp.dummy = #random_event_roll_1 sgp.dummy \
        run scoreboard players operation #random_event_roll_2 sgp.dummy += 1 sgp.dummy

$execute if score 3 sgp.dummy matches $(nbr) \
    if score #random_event_roll_3 sgp.dummy = #random_event_roll_1 sgp.dummy \
        run scoreboard players operation #random_event_roll_3 sgp.dummy += 1 sgp.dummy

$execute if score 3 sgp.dummy matches $(nbr) \
    if score #random_event_roll_3 sgp.dummy = #random_event_roll_2 sgp.dummy \
        run scoreboard players operation #random_event_roll_3 sgp.dummy += 1 sgp.dummy


$execute if score #random_event_roll_$(nbr) sgp.dummy = #last_event_1 sgp.dummy \
    run return run scoreboard players operation #random_event_roll_$(nbr) sgp.dummy += 1 sgp.dummy

$execute if score #last_nbr_events sgp.dummy matches 2.. \
    if score #random_event_roll_$(nbr) sgp.dummy = #last_event_2 sgp.dummy \
        run return run scoreboard players operation #random_event_roll_$(nbr) sgp.dummy += 1 sgp.dummy

$execute if score #last_nbr_events sgp.dummy matches 3.. \
    if score #random_event_roll_$(nbr) sgp.dummy = #last_event_3 sgp.dummy \
        run return run scoreboard players operation #random_event_roll_$(nbr) sgp.dummy += 1 sgp.dummy
