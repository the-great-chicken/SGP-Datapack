#> sgp.ci:teleporter/advance
# `{ticks: positive int}`
#
# Run the complete production teleporter list once per simulated tick.

$scoreboard players set #ci.portal.steps sgp.dummy $(ticks)
function sgp.ci:teleporter/step
