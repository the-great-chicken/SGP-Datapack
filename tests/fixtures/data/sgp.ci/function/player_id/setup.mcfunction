#> sgp.ci:player_id/setup

function sgp.ci:players/cleanup
execute store success score #ci.id.had_counter sgp.dummy store result score #ci.id.saved_counter sgp.dummy run scoreboard players get #global sgp.id
