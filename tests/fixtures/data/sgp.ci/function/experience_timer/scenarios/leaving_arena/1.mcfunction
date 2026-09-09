#> sgp.ci:experience_timer/scenarios/leaving_arena/1

function sgp.ci:experience_timer/fixture
function sgp.misc:timer_experience {duration:4}
function sgp.misc:players_in_game/leave
function sgp.ci:experience_timer/expect_empty
experience set @s 7 levels
