#> sgp.misc:player_id/new_players
# @dummy
# @environment sgp.ci:player_id/new_players
#
# New players receive distinct positive IDs; repeating assignment preserves them.

function sgp.ci:player_id/roster
scoreboard players reset @s sgp.id
scoreboard players reset IdPeer sgp.id
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 1001..1002
assert score IdPeer sgp.id matches 1001..1002
execute if score @s sgp.id = IdPeer sgp.id run fail "Players received the same ID"
assert score #global sgp.id matches 1002
scoreboard players operation #ci.id.first sgp.dummy = @s sgp.id
scoreboard players operation #ci.id.second sgp.dummy = IdPeer sgp.id
function sgp.misc:player_id/ensure
execute unless score @s sgp.id = #ci.id.first sgp.dummy run fail "The first player ID changed"
execute unless score IdPeer sgp.id = #ci.id.second sgp.dummy run fail "The second player ID changed"
assert score #global sgp.id matches 1002
