#> sgp.misc:experience_timer/audience
# @dummy
# @environment sgp.ci:experience_timer/audience
#
# The countdown affects all in-game players and preserves a spectator's experience.

function sgp.ci:experience_timer/fixture
dummy TimerPeer spawn
dummy TimerOutside spawn
tag TimerPeer add sgp.in_game
experience set TimerOutside 9 levels
experience set TimerOutside 4 points
function sgp.misc:timer_experience {duration:3}
function sgp.ci:experience_timer/expect_level {level:2}
execute as TimerPeer run function sgp.ci:experience_timer/expect_level {level:2}
await delay 41t
function sgp.ci:experience_timer/expect_empty
execute as TimerPeer run function sgp.ci:experience_timer/expect_empty
execute as TimerOutside run function sgp.ci:experience_timer/expect_level {level:9}
execute store result score #ci.xp.outside sgp.dummy run experience query TimerOutside points
assert score #ci.xp.outside sgp.dummy matches 4
