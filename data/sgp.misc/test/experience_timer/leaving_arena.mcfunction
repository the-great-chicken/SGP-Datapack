#> sgp.misc:experience_timer/leaving_arena
# @dummy
# @environment sgp.ci:experience_timer/leaving_arena
#
# Leaving the arena clears its timer display and later countdown updates do not overwrite the former participant's experience.

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:4}
function sgp.misc:players_in_game/leave
function sgp.ci:experience_timer/expect_empty
experience set @s 7 levels
await delay 21t
function sgp.ci:experience_timer/expect_level {level:7}
assert not entity @s[tag=sgp.in_game]
