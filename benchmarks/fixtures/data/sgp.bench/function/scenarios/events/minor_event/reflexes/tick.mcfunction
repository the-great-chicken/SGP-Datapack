#> sgp.bench:scenarios/events/minor_event/reflexes/tick
# `{first, last, players, event}`
# Restart before the 100-tick deadline so nobody gets the TNT; every player stays unanswered.
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c90 sgp.bench
execute unless score #minor_mod sgp.bench matches 0 run return 0
function sgp.mineurs:reflexes/start
scoreboard players add #minor_actions sgp.bench 1
