#> sgp.ci:minor_events/cleanup_bounty
# Stop Bounty through its production cleanup, clear shared timing work, and disconnect players.

function sgp.mineurs:bounty/stop
schedule clear sgp.misc:second
function sgp.ci:players/cleanup
