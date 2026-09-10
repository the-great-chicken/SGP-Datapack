#> sgp.ci:minor_events/advance
# `{function: string, ticks: int}`
#
# Advance one event's real update function synchronously; ticks must be positive.

$data modify storage sgp.ci:minor_events advance set value {function:"$(function)"}
$scoreboard players set #ci_minor_remaining sgp.dummy $(ticks)
function sgp.ci:minor_events/step with storage sgp.ci:minor_events advance
data remove storage sgp.ci:minor_events advance
