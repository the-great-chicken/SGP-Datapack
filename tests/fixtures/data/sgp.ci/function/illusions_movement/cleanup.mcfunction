#> sgp.ci:illusions_movement/cleanup
# Remove illusion entities, disconnect players, and clear the loaded-region probe.

function sgp.ci:illusions_movement/clear
function sgp.ci:players/cleanup
kill @e[tag=sgp.ci.origin_ready,type=marker]
