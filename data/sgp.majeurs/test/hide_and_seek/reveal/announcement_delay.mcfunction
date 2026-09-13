#> sgp.majeurs:hide_and_seek/reveal/announcement_delay
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/announcement_delay
#
# The five-second warning precedes the scheduled reveal instead of exposing hiders immediately.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow_announce
function sgp.ci:hider_reveal/scenarios/expect_hidden
await delay 80t
function sgp.ci:hider_reveal/scenarios/expect_hidden
await delay 21t
function sgp.ci:hider_reveal/scenarios/expect_visible
