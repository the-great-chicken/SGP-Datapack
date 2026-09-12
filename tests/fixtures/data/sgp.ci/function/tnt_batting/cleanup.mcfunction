#> sgp.ci:tnt_batting/cleanup
# Remove batted TNT, disconnect players, and clear fixture owner state.

kill @e[tag=sgp.ci.batted_tnt,type=tnt]
kill @e[tag=sgp.ci.other_tnt,type=tnt]
function sgp.ci:players/cleanup
data remove storage sgp.ci:tnt_batting owner
