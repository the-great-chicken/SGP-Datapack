#> sgp.ci:player_id/scenarios/valid_ids

function sgp.ci:player_id/roster
scoreboard players set @s sgp.id 42
scoreboard players set IdPeer sgp.id 88
function sgp.misc:player_id/ensure
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 42
assert score IdPeer sgp.id matches 88
assert score #global sgp.id matches 1000
