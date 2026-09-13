#> sgp.ci:minor_scheduler/cleanup
# Restore scheduler scores exactly as setup found them.

scoreboard players reset #ci.minor.delay sgp.dummy
execute if score #ci.minor.had0 sgp.dummy matches 1 run scoreboard players operation #events_mineurs_actifs sgp.dummy = #ci.minor.saved0 sgp.dummy
execute if score #ci.minor.had0 sgp.dummy matches 0 run scoreboard players reset #events_mineurs_actifs sgp.dummy
execute if score #ci.minor.had1 sgp.dummy matches 1 run scoreboard players operation #events_mineurs sgp.timer = #ci.minor.saved1 sgp.dummy
execute if score #ci.minor.had1 sgp.dummy matches 0 run scoreboard players reset #events_mineurs sgp.timer
execute if score #ci.minor.had2 sgp.dummy matches 1 run scoreboard players operation #events_mineurs_seconds sgp.timer = #ci.minor.saved2 sgp.dummy
execute if score #ci.minor.had2 sgp.dummy matches 0 run scoreboard players reset #events_mineurs_seconds sgp.timer
execute if score #ci.minor.had3 sgp.dummy matches 1 run scoreboard players operation #random_event_timer_roll sgp.dummy = #ci.minor.saved3 sgp.dummy
execute if score #ci.minor.had3 sgp.dummy matches 0 run scoreboard players reset #random_event_timer_roll sgp.dummy
execute if score #ci.minor.had4 sgp.dummy matches 1 run scoreboard players operation #random_event_timer_roll_minus_60 sgp.dummy = #ci.minor.saved4 sgp.dummy
execute if score #ci.minor.had4 sgp.dummy matches 0 run scoreboard players reset #random_event_timer_roll_minus_60 sgp.dummy
scoreboard players reset #ci.minor.had0 sgp.dummy
scoreboard players reset #ci.minor.saved0 sgp.dummy
scoreboard players reset #ci.minor.had1 sgp.dummy
scoreboard players reset #ci.minor.saved1 sgp.dummy
scoreboard players reset #ci.minor.had2 sgp.dummy
scoreboard players reset #ci.minor.saved2 sgp.dummy
scoreboard players reset #ci.minor.had3 sgp.dummy
scoreboard players reset #ci.minor.saved3 sgp.dummy
scoreboard players reset #ci.minor.had4 sgp.dummy
scoreboard players reset #ci.minor.saved4 sgp.dummy
