#> sgp.ci:round_scheduling/cleanup
# Stop round scheduling, clear unrelated fixture work, disconnect players, and restore optional round-limit scores.

function sgp.majeurs:scheduler/stop
schedule clear sgp.ci:round_scheduling/unrelated
function sgp.ci:players/cleanup
execute if score #ci.round.had0 sgp.dummy matches 1 run scoreboard players operation #rounds sgp.dummy = #ci.round.saved0 sgp.dummy
execute if score #ci.round.had0 sgp.dummy matches 0 run scoreboard players reset #rounds sgp.dummy
execute if score #ci.round.had1 sgp.dummy matches 1 run scoreboard players operation #pco_max_rounds sgp.dummy = #ci.round.saved1 sgp.dummy
execute if score #ci.round.had1 sgp.dummy matches 0 run scoreboard players reset #pco_max_rounds sgp.dummy
execute if score #ci.round.had2 sgp.dummy matches 1 run scoreboard players operation #hide_and_seek_max_rounds sgp.dummy = #ci.round.saved2 sgp.dummy
execute if score #ci.round.had2 sgp.dummy matches 0 run scoreboard players reset #hide_and_seek_max_rounds sgp.dummy
execute if score #ci.round.had3 sgp.dummy matches 1 run scoreboard players operation #protect_max_rounds sgp.dummy = #ci.round.saved3 sgp.dummy
execute if score #ci.round.had3 sgp.dummy matches 0 run scoreboard players reset #protect_max_rounds sgp.dummy
