#> minecraft:even_tick_functions
# 
# Executes functions one game tick out of 2 

execute if score #even_tick sgp.dummy matches 0 run \
    function sgp.cosmetics:misc/store_coords
execute if score #even_tick sgp.dummy matches 0 run \
    function sgp.world:run_lieux_trouves

execute if score #even_tick sgp.dummy matches 0 \
    if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:misc/check_if_players

execute if score #even_tick sgp.dummy matches 0 \
    if score #events_mineurs_actifs sgp.dummy matches 1 \
        run function sgp.mineurs:common/timer

scoreboard players add #even_tick sgp.dummy 1

execute if score #even_tick sgp.dummy matches 2 run scoreboard players set #even_tick sgp.dummy 0