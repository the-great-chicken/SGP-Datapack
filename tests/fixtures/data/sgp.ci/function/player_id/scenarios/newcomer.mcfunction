#> sgp.ci:player_id/scenarios/newcomer

function sgp.ci:player_id/roster
scoreboard players set @s sgp.id 700
scoreboard players reset IdPeer sgp.id
function sgp.misc:player_id/ensure
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 700
assert score IdPeer sgp.id matches 1001
assert score #global sgp.id matches 1001
