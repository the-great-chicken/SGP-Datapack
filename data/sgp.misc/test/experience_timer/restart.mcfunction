#> sgp.misc:experience_timer/restart
# @dummy
# @environment sgp.ci:experience_timer/restart
#
# Restarting replaces the pending second tick instead of allowing the old countdown to shorten the new one.

function sgp.ci:experience_timer/scenarios/restart/1
await delay 10t
function sgp.ci:experience_timer/scenarios/restart/2
await delay 11t
function sgp.ci:experience_timer/scenarios/restart/3
await delay 10t
function sgp.ci:experience_timer/scenarios/restart/4
await delay 20t
function sgp.ci:experience_timer/scenarios/restart/5
