#> sgp.ci:round_scheduling/setup
# Stop stale scheduling and snapshot the current round count and per-event round limits.

function sgp.ci:players/cleanup
function sgp.majeurs:scheduler/stop
execute store success score #ci.round.had0 sgp.dummy store result score #ci.round.saved0 sgp.dummy run scoreboard players get #rounds sgp.dummy
execute store success score #ci.round.had1 sgp.dummy store result score #ci.round.saved1 sgp.dummy run scoreboard players get #pco_max_rounds sgp.dummy
execute store success score #ci.round.had2 sgp.dummy store result score #ci.round.saved2 sgp.dummy run scoreboard players get #hide_and_seek_max_rounds sgp.dummy
execute store success score #ci.round.had3 sgp.dummy store result score #ci.round.saved3 sgp.dummy run scoreboard players get #protect_max_rounds sgp.dummy
