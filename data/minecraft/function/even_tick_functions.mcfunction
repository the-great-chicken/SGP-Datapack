#> minecraft:even_tick_functions
# 
# Executes functions one game tick out of 2 

function sgp.cosmetics:misc/store_coords

execute as @e[type=marker,tag=sgp.marker,name="lieu"] \
        run function sgp.world:lieu/lieu_trouve with entity @s data

execute as @e[type=marker,tag=sgp.marker,name="pvp_arena",limit=1] at @s \
        run function sgp.misc:players_in_game with entity @s data

execute if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:misc/check_if_players

execute if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:common/timer
