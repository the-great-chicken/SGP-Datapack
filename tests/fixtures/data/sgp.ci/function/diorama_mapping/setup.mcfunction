#> sgp.ci:diorama_mapping/setup
# Disconnect stale players, save the production update interval, and load the mapping test region.

function sgp.ci:players/cleanup
execute store result storage sgp.ci:diorama_mapping update_time int 1 run scoreboard players get #mannequin_update_time sgp.dummy
forceload add 0 0 32 32
