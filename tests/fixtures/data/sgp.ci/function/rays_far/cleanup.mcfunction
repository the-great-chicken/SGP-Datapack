#> sgp.ci:rays_far/cleanup
# Remove Rays displays and the far arena, then disconnect fixture players.

execute positioned 1008.0 88.0 1008.0 run kill @e[tag=sgp.ray,distance=..64,type=item_display]
kill @e[tag=sgp.ci.far_ready,type=marker]
function sgp.ci:players/cleanup
fill 988 87 988 1028 92 1028 air
forceload remove 984 984 1032 1032
