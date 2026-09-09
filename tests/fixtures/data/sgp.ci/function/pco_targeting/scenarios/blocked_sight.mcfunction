#> sgp.ci:pco_targeting/scenarios/blocked_sight

function sgp.ci:pco_targeting/fixture
fill ~2 ~1 ~4 ~2 ~3 ~4 stone
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
fill ~2 ~1 ~4 ~2 ~3 ~4 air
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
