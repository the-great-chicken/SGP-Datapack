#> sgp.majeurs:hide_and_seek/rounds/last_hider_disconnects
# @dummy
# @environment sgp.ci:hider_teams
#
# Losing the last online hider finishes the round even without a death callback.

function sgp.ci:hider_teams/round_roster
dummy HsGroup2 leave
function sgp.majeurs:hide_and_seek/running
assert chat ".*Chasseurs ont gagné.*" @s
assert not chat ".*Volaille a survécu.*" @s
function sgp.ci:hider_teams/expect_round_finished
