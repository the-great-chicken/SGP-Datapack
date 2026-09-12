#> sgp.ci:kill_effects/cleanup
# Remove spawned kill-effect entities and fixture markers, then disconnect players.

kill @e[tag=sgp.ci.kill_effect,type=falling_block]
kill @e[tag=sgp.ci.kill_effect,type=firework_rocket]
kill @e[tag=sgp.ci.effect_marker,type=marker]
function sgp.ci:players/cleanup
