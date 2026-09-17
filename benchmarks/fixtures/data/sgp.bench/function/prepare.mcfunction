#> sgp.bench:prepare
# `{players: 0..40}`
# Reset the previous run, create the requested actor roster, and initialize normal SGP player state.

function sgp.bench:reset
$scoreboard players set #players sgp.bench $(players)
scoreboard players set #ticks sgp.bench 0
scoreboard players set #actions sgp.bench 0
function sgp.bench:actors/spawn
