#> sgp.misc:experience_timer/short_timer
# @dummy
# @environment sgp.ci:experience_timer/short_timer
#
# A one-second timer finishes immediately and leaves no scheduled decrement behind.

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:1}
function sgp.ci:experience_timer/expect_empty
experience set @s 7 levels
await delay 21t
function sgp.ci:experience_timer/expect_level {level:7}
