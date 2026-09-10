#> sgp.ci:teleporter/cleanup
# Remove portal/destination markers, disconnect players, and clear teleporter fixture state.

kill @e[tag=sgp.ci.teleporter,type=marker]
function sgp.ci:players/cleanup
data remove storage sgp.ci:teleporter state
