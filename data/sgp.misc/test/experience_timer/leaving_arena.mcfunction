#> sgp.misc:experience_timer/leaving_arena
# @dummy
# @environment sgp.ci:experience_timer/leaving_arena
#
# Leaving the arena clears its timer display and later countdown updates do not overwrite the former participant's experience.

function sgp.ci:experience_timer/scenarios/leaving_arena/1
await delay 21t
function sgp.ci:experience_timer/scenarios/leaving_arena/2
