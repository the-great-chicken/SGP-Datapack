#> sgp.ci:minor_events/step
# `{function: string}`

$function $(function)
scoreboard players remove #ci_minor_remaining sgp.dummy 1
execute if score #ci_minor_remaining sgp.dummy matches 1.. run function sgp.ci:minor_events/step with storage sgp:data tests.minor_advance
