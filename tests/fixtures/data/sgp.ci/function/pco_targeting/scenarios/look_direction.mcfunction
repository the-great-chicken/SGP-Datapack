#> sgp.ci:pco_targeting/scenarios/look_direction

function sgp.ci:pco_targeting/fixture
tp @s ~2.5 ~1 ~2.5 180 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
tp @s ~2.5 ~1 ~2.5 0 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
