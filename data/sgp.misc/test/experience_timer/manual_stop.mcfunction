#> sgp.misc:experience_timer/manual_stop
# @dummy
# @environment sgp.ci:experience_timer/manual_stop
#
# Setting the clock to zero clears the display at the next scheduled update and stops further updates.

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:5}
scoreboard players set #second sgp.timer 0
await delay 21t
function sgp.ci:experience_timer/expect_empty
experience set @s 7 levels
await delay 21t
function sgp.ci:experience_timer/expect_level {level:7}
