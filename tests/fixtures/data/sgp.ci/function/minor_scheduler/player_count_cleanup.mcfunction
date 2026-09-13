#> sgp.ci:minor_scheduler/player_count_cleanup
# Disconnect test dummies and restore the two global scores exactly.

function sgp.ci:players/cleanup
execute if score #ci.count.had0 sgp.dummy matches 1 run scoreboard players operation #events_mineurs_actifs sgp.dummy = #ci.count.saved0 sgp.dummy
execute if score #ci.count.had0 sgp.dummy matches 0 run scoreboard players reset #events_mineurs_actifs sgp.dummy
execute if score #ci.count.had1 sgp.dummy matches 1 run scoreboard players operation #nbr_de_joueurs sgp.dummy = #ci.count.saved1 sgp.dummy
execute if score #ci.count.had1 sgp.dummy matches 0 run scoreboard players reset #nbr_de_joueurs sgp.dummy
scoreboard players reset #ci.count.had0 sgp.dummy
scoreboard players reset #ci.count.saved0 sgp.dummy
scoreboard players reset #ci.count.had1 sgp.dummy
scoreboard players reset #ci.count.saved1 sgp.dummy
