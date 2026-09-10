#> sgp.misc:player_id/fresh_counter
# @dummy
# @environment sgp.ci:player_id/fresh_counter
#
# The first assignment also works before the global counter exists.

function sgp.ci:player_id/roster
dummy IdPeer leave
scoreboard players reset #global sgp.id
scoreboard players reset @s sgp.id
function sgp.misc:player_id/ensure
assert score @s sgp.id matches 1
assert score #global sgp.id matches 1
