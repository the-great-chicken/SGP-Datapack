#> sgp.majeurs:hide_and_seek/reveal/expiry
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/expiry
#
# The reveal lasts three seconds and does not remain on players indefinitely.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow
function sgp.ci:hider_reveal/scenarios/expect_visible
await delay 61t
function sgp.ci:hider_reveal/scenarios/expect_hidden
