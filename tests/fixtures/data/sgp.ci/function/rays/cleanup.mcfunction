#> sgp.ci:rays/cleanup
# Remove Rays displays/predictors and arena changes, then disconnect fixture players.

execute positioned 8.0 88.0 8.0 run kill @e[tag=sgp.ray,distance=..64,type=item_display]
kill @e[tag=sgp.ci.ray_other,type=item_display]
kill @e[tag=sgp.ci.origin_ready,type=marker]
execute positioned 8.0 88.0 8.0 run kill @e[tag=sgp.predictor,distance=..64,type=marker]
function sgp.ci:players/cleanup

# Water and wall fixtures must not spill into later origin-arena tests.
fill -12 88 -12 28 92 28 air
