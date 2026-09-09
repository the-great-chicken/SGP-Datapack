#> sgp.ci:player_id/scenarios/fresh_counter

function sgp.ci:player_id/roster
dummy IdPeer leave
scoreboard players reset #global sgp.id
scoreboard players reset @s sgp.id
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 1
assert score #global sgp.id matches 1
