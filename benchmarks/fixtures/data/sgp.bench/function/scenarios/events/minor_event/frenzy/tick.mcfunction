#> sgp.bench:scenarios/events/minor_event/frenzy/tick
# `{first, last, players, event}`
# All of frenzy's cost is at start (the SNBT walker over the cooldown table): cycle it.
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c60 sgp.bench
execute if score #minor_mod sgp.bench matches 30 run function sgp.mineurs:frenzy/stop
execute unless score #minor_mod sgp.bench matches 0 run return 0
function sgp.mineurs:frenzy/start
scoreboard players add #minor_actions sgp.bench 1
