#> sgp.ci:minor_events/step
# `{function: function id}`
#
# Run one synchronous event update and recurse until the requested simulated tick count is exhausted.

$function $(function)
scoreboard players remove #ci_minor_remaining sgp.dummy 1
execute if score #ci_minor_remaining sgp.dummy matches 1.. run function sgp.ci:minor_events/step with storage sgp.ci:minor_events advance
