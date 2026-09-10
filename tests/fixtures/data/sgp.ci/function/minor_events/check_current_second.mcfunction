#> sgp.ci:minor_events/check_current_second
# `{nbr: 1..3}`
#
# Require the candidate event not to repeat the second event already selected for this roll.

$assert not score #random_event_roll_$(nbr) sgp.dummy = #random_event_roll_2 sgp.dummy
