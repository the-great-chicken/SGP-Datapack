#> sgp.ci:interaction_dispatch/cleanup
# Remove fixture interactions and disconnect every test player.

kill @e[tag=sgp.ci.interaction,type=interaction]
function sgp.ci:players/cleanup
