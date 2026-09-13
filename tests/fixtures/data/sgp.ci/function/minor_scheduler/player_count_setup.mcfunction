#> sgp.ci:minor_scheduler/player_count_setup
# Isolate dummy players and the two global scores touched by the player-count test.

function sgp.ci:players/cleanup
execute store success score #ci.count.had0 sgp.dummy store result score #ci.count.saved0 sgp.dummy run scoreboard players get #events_mineurs_actifs sgp.dummy
execute store success score #ci.count.had1 sgp.dummy store result score #ci.count.saved1 sgp.dummy run scoreboard players get #nbr_de_joueurs sgp.dummy
scoreboard players set #events_mineurs_actifs sgp.dummy 0
scoreboard players set #nbr_de_joueurs sgp.dummy 0
