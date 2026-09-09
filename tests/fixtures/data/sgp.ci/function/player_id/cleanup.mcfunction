#> sgp.ci:player_id/cleanup

function sgp.ci:players/cleanup
execute if score #ci.id.had_counter sgp.dummy matches 1 run scoreboard players operation #global sgp.id = #ci.id.saved_counter sgp.dummy
execute if score #ci.id.had_counter sgp.dummy matches 0 run scoreboard players reset #global sgp.id
