#> sgp.majeurs:hide_and_seek/rounds/surviving_hiders
# @dummy
# @environment sgp.ci:hider_teams
#
# The round deadline awards surviving hiders and releases the state of both roles, including accumulated group penalties.

function sgp.ci:hider_teams/round_roster
scoreboard players set #seeker sgp.timer 0
function sgp.majeurs:hide_and_seek/timer/seeker
scoreboard players set HsGroup2 sgp.teammate_deaths 2
tag HsGroup2 add sgp.lost_jump_msg
tag HsGroup2 add sgp.lost_speed_msg
scoreboard players set HsGroup2 sgp.ab.hide_hider 40
function sgp.majeurs:hide_and_seek/running
assert score #rounds sgp.dummy matches 0
# This is the callback scheduled for the round deadline.
function sgp.majeurs:hide_and_seek/_stop
assert chat ".*Volaille a survécu.*" @s
assert not chat ".*Chasseurs ont gagné.*" @s
function sgp.ci:hider_teams/expect_round_finished
