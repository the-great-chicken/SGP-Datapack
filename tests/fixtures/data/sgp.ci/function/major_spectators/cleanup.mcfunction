#> sgp.ci:major_spectators/cleanup
# Cancel delayed major-event work and disconnect all spectator-test players.

function #bs.schedule:cancel_all {with:{id:"major_event"}}
function sgp.ci:players/cleanup
