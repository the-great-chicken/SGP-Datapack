#> sgp.majeurs:hide_and_seek/reveal/refresh
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/refresh
#
# Refreshing a reveal extends visibility from the latest reveal, then expires normally.

function sgp.ci:hider_reveal/roster
function sgp.ci:hider_reveal/scenarios/refresh
await delay 40t
function sgp.ci:hider_reveal/scenarios/refresh
await delay 40t
function sgp.ci:hider_reveal/scenarios/expect_visible
await delay 21t
function sgp.ci:hider_reveal/scenarios/expect_hidden
