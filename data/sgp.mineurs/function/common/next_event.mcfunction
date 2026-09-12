#> sgp.mineurs:common/next_event
# `{nbr: int}`
#
# Advance and recheck all conflicts, including after wrapping from seven to one.
# At most five of seven events are excluded by the previous round and current picks.

$scoreboard players add #random_event_roll_$(nbr) sgp.dummy 1
$return run function sgp.mineurs:common/change_event_if_same {nbr:$(nbr)}
