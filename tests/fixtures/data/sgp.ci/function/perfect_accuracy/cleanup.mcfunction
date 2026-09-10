#> sgp.ci:perfect_accuracy/cleanup
# Remove supported test projectiles, disconnect players, and remove the loaded-region probe.

function sgp.ci:perfect_accuracy/clear_projectiles
function sgp.ci:players/cleanup
kill @e[tag=sgp.ci.origin_ready,type=marker]
