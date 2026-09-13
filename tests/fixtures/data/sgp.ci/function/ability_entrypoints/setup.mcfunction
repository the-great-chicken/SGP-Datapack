#> sgp.ci:ability_entrypoints/setup
# Start each public-activation test with no stale dummies, artifacts, or synthetic telemetry rows.

function sgp.ci:players/cleanup
kill @e[tag=sgp.ci.ability_entrypoint]
data remove storage sgp.kits:stats kits_dict.920001
data remove storage sgp.kits:stats kits_dict.920002
data remove storage sgp.kits:stats kits_dict.920003
data remove storage sgp.kits:stats kits_dict.920004
data remove storage sgp.kits:stats kits_dict.920005
data remove storage sgp.kits:stats kits_dict.920006
