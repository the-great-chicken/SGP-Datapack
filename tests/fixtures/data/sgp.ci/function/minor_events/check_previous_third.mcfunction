#> sgp.ci:minor_events/check_previous_third
# `{nbr: 1..3}`
#
# Require the candidate event not to repeat the third entry in recent event history.

$assert not score #random_event_roll_$(nbr) sgp.dummy = #last_event_3 sgp.dummy
