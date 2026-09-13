#> sgp.majeurs:hide_and_seek/rounds/last_hider_dies
# @dummy
# @environment sgp.ci:hider_teams
#
# Catching the last hider awards the seekers and ends the round instead of starting another conversion countdown.

function sgp.ci:hider_teams/round_roster
function sgp.majeurs:hide_and_seek/running
assert score #rounds sgp.dummy matches 0
execute as HsGroup2 run function sgp.majeurs:hide_and_seek/died
assert chat ".*Chasseurs ont gagné.*" @s
assert not chat ".*Volaille a survécu.*" @s
assert not score HsGroup2 sgp.timer matches 0..
function sgp.ci:hider_teams/expect_round_finished
