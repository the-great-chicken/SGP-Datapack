#> sgp.majeurs:pco/targeting/range
# @dummy
# @environment sgp.ci:pco_targeting/range
#
# Visible prey just inside the hunting range grants the bonus; prey just outside does not.

function sgp.ci:pco_targeting/fixture
tp PcoPrey ~2.5 ~1 ~5.8 180 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
effect clear @s minecraft:strength
tp PcoPrey ~2.5 ~1 ~6.0 180 0
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
