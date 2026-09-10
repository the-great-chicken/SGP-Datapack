#> sgp.ci:tnt_detonation/cleanup
# Remove lingering-fire results and all TNT click fixtures.

kill @e[tag=sgp.ci.detonation_fire,type=marker]
function sgp.ci:tnt_clicks/cleanup
