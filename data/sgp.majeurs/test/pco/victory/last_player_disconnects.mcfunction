#> sgp.majeurs:pco/victory/last_player_disconnects
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Losing one member keeps a team alive; losing its last online member awards its predator without requiring a capture.

function sgp.ci:pco/round_fixture
dummy PcoRoundOie leave
function sgp.majeurs:pco/running
assert score #pco_phase sgp.dummy matches 2
assert score #rounds sgp.dummy matches 0

# The sole Poule disconnects while both surviving teams still have an online member.
dummy PcoRoundPoule leave
function sgp.majeurs:pco/running
assert chat ".*Oies gagnent.*Poule.*n'a plus de participant.*" @s
assert score #pco_phase sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
function sgp.ci:pco/expect_teams {total:0,min:0,max:0}
assert not entity @a[tag=sgp.ci.pco_actor,tag=sgp.major_participant]
function sgp.majeurs:pco/running
assert score #rounds sgp.dummy matches 1
