#> sgp.majeurs:pco/targeting/blocked_sight
# @dummy
# @environment sgp.ci:pco_targeting/blocked_sight
#
# A solid wall prevents the hunting bonus; removing it restores targeting.

function sgp.ci:pco_targeting/fixture
fill ~2 ~1 ~4 ~2 ~3 ~4 stone
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
fill ~2 ~1 ~4 ~2 ~3 ~4 air
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
