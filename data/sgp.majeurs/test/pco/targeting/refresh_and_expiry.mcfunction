#> sgp.majeurs:pco/targeting/refresh_and_expiry
# @dummy
# @environment sgp.ci:pco_targeting/refresh_and_expiry
#
# Continued targeting refreshes the bonus, which expires naturally after the hunter looks away.

function sgp.ci:pco_targeting/fixture
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:7000}
await delay 10t
function sgp.ci:pco_targeting/expect_damage {damage:7000}
function sgp.majeurs:pco/empower
await delay 11t
function sgp.ci:pco_targeting/expect_damage {damage:7000}
tp @s ~2.5 ~1 ~2.5 180 0
function sgp.majeurs:pco/empower
await delay 21t
function sgp.ci:pco_targeting/expect_damage {damage:1000}
