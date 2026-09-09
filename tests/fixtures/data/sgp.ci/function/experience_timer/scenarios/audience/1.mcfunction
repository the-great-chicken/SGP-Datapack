#> sgp.ci:experience_timer/scenarios/audience/1

function sgp.ci:experience_timer/fixture
dummy TimerPeer spawn
dummy TimerOutside spawn
tag TimerPeer add sgp.in_game
experience set TimerOutside 9 levels
experience set TimerOutside 4 points
function sgp.misc:timer_experience {duration:3}
function sgp.ci:experience_timer/expect_level {level:2}
execute as TimerPeer run function sgp.ci:experience_timer/expect_level {level:2}
