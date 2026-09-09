#> sgp.ci:pco_targeting/scenarios/range

function sgp.ci:pco_targeting/fixture
tp PcoPrey ~2.5 ~1 ~5.8 180 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
effect clear @s minecraft:strength
tp PcoPrey ~2.5 ~1 ~6.0 180 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
