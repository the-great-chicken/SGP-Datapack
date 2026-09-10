#> sgp.ci:teleporter/cleanup

kill @e[tag=sgp.ci.teleporter,type=marker]
function sgp.ci:players/cleanup
data remove storage sgp.ci:teleporter state
