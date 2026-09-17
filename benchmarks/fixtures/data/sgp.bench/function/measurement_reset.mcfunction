#> sgp.bench:measurement_reset
# Reset counters immediately before the measured /perf window.

scoreboard players set #ticks sgp.bench 0
function sgp.bench:generated/active/measurement_reset
