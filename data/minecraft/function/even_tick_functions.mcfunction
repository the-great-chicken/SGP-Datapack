#> minecraft:even_tick_functions
# 
# Executes functions one game tick out of 2 

execute if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:misc/check_if_players

execute if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:common/timer

