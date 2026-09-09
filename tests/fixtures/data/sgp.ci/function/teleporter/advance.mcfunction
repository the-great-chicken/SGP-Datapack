#> sgp.ci:teleporter/advance
# {ticks}: run the same complete teleporter list once per simulated game tick.

$scoreboard players set #ci.portal.steps sgp.dummy $(ticks)
function sgp.ci:teleporter/step
