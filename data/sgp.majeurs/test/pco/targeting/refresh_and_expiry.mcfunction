#> sgp.majeurs:pco/targeting/refresh_and_expiry
# @dummy
# @environment sgp.ci:pco_targeting/refresh_and_expiry
#
# Continued targeting refreshes the bonus, which expires naturally after the hunter looks away.

function sgp.ci:pco_targeting/scenarios/refresh_and_expiry/start
await delay 10t
function sgp.ci:pco_targeting/scenarios/refresh_and_expiry/refresh
await delay 11t
function sgp.ci:pco_targeting/scenarios/refresh_and_expiry/look_away
await delay 21t
function sgp.ci:pco_targeting/expect_damage {damage:1000}
