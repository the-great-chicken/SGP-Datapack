#> sgp.misc:player_id/invalid_ids
# @dummy
# @environment sgp.ci:player_id/invalid_ids
#
# Zero and negative IDs are replaced with distinct valid IDs.

function sgp.ci:player_id/roster
scoreboard players set @s sgp.id 0
scoreboard players set IdPeer sgp.id -3
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 1001..1002
assert score IdPeer sgp.id matches 1001..1002
execute if score @s sgp.id = IdPeer sgp.id run fail "Players received the same ID"
assert score #global sgp.id matches 1002
