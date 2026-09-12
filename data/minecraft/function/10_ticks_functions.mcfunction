#> minecraft:10_ticks_functions
#
# Runs every 10 game ticks.

execute as @a[tag=sgp.in_game,tag=sgp.peaceful] at @s \
    run particle minecraft:heart ~ ~2 ~ 0.1 0 0.1 1 1