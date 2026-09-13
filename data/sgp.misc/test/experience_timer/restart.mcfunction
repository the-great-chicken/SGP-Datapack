#> sgp.misc:experience_timer/restart
# @dummy
# @environment sgp.ci:experience_timer/restart
#
# Restarting replaces the pending second tick instead of allowing the old countdown to shorten the new one.

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:5}
await delay 10t
function sgp.misc:timer_experience {duration:4}
function sgp.ci:experience_timer/expect_level {level:3}
await delay 11t
function sgp.ci:experience_timer/expect_level {level:3}
await delay 10t
function sgp.ci:experience_timer/expect_level {level:2}
await delay 20t
function sgp.ci:experience_timer/expect_level {level:1}
