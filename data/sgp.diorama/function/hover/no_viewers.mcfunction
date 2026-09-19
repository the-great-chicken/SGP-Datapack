#> sgp.diorama:hover/no_viewers
# `{id: int}`
# Executed as and at a playable_map_model with no current hover viewers.

# Spawn buttons can lie outside the model volume. Use their model ID, like the UUID cache.
$scoreboard players remove @e[tag=sgp.spawn_tper_$(id),scores={sgp.hover_time=1..},type=interaction] sgp.hover_time 1

# A positive grace was already grown by check_target; only expiry changes its display.
$execute as @e[tag=sgp.spawn_tper_$(id),tag=sgp.spawn_hovered,scores={sgp.hover_time=0},type=interaction] at @s run function sgp.diorama:hover/shrink

return 1
