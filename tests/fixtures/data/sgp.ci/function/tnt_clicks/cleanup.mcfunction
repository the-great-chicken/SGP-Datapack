#> sgp.ci:tnt_clicks/cleanup
# Remove TNT/interaction pairs, disconnect players, and clear click fixture state.

kill @e[tag=sgp.ci.click_a,type=interaction]
kill @e[tag=sgp.ci.click_b,type=interaction]
kill @e[tag=sgp.ci.click_tnt_a,type=tnt]
kill @e[tag=sgp.ci.click_tnt_b,type=tnt]
data remove storage sgp.ci:tnt_clicks attack
function sgp.ci:players/cleanup
