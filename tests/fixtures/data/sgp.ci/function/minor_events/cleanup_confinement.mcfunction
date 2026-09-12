#> sgp.ci:minor_events/cleanup_confinement
# Stop Confinement through its production cleanup, clear shared timing work, and disconnect players.

function sgp.mineurs:confinement/stop
schedule clear sgp.misc:second
function sgp.ci:players/cleanup
