#> sgp.bench:scenarios/events/minor_event/swap/tick
# `{first, last, players, event}`
# Swap is a one-tick burst (a full kit give for every in-game player); repeat it every 100 ticks.
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c100 sgp.bench
execute unless score #minor_mod sgp.bench matches 0 run return 0
function sgp.mineurs:swap/start
scoreboard players add #minor_actions sgp.bench 1
