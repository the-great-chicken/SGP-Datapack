#> sgp.misc:experience_timer/countdown
# @dummy
# @environment sgp.ci:experience_timer/countdown
#
# The visible countdown advances once per second and clears levels and progress when it ends.

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:3}
function sgp.ci:experience_timer/expect_level {level:2}
await delay 21t
function sgp.ci:experience_timer/expect_level {level:1}
await delay 20t
function sgp.ci:experience_timer/expect_empty
