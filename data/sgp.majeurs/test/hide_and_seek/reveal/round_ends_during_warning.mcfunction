#> sgp.majeurs:hide_and_seek/reveal/round_ends_during_warning
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/round_ends_during_warning
#
# A pending reveal stops when the round ends during its warning and does not start another cycle.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow_announce
await delay 40t
function sgp.ci:hider_reveal/scenarios/end_round
await delay 61t
function sgp.ci:hider_reveal/scenarios/expect_stopped
