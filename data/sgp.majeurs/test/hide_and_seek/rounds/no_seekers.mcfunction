#> sgp.majeurs:hide_and_seek/rounds/no_seekers
# @dummy
# @environment sgp.ci:hider_teams
#
# Hiders win if the last seeker disconnects; a round with both roles still present must continue.

function sgp.ci:hider_teams/round_roster
function sgp.majeurs:hide_and_seek/reset_player
function sgp.majeurs:hide_and_seek/role/hider
tag @s add sgp.hider
function sgp.majeurs:hide_and_seek/running
assert score #rounds sgp.dummy matches 0
assert entity @s[team=sgp.hider]
dummy HsGroup1 leave
function sgp.majeurs:hide_and_seek/running
assert chat ".*Volaille a survécu.*" @s
assert not chat ".*Chasseurs ont gagné.*" @s
function sgp.ci:hider_teams/expect_round_finished
