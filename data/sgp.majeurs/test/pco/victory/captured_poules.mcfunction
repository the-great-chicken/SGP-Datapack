#> sgp.majeurs:pco/victory/captured_poules
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Capturing all Poules awards the Oies, even though members of the other teams remain free.

function sgp.ci:pco/round_fixture
function sgp.majeurs:pco/running
assert score #pco_phase sgp.dummy matches 2
tp PcoRoundPoule ~10.5 ~2 ~0.5
function sgp.majeurs:pco/running
assert chat ".*Oies victorieuses.*" @s
assert not chat ".*Poules victorieuses.*" @s
assert not chat ".*Canards victorieux.*" @s
assert score #pco_phase sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
function sgp.ci:pco/expect_teams {total:0,min:0,max:0}
