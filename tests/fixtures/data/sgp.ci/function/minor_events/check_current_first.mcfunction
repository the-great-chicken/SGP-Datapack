#> sgp.ci:minor_events/check_current_first
# `{nbr: 1..3}`
#
# Require the candidate event not to repeat the first event already selected for this roll.

$assert not score #random_event_roll_$(nbr) sgp.dummy = #random_event_roll_1 sgp.dummy
