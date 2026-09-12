#> sgp.ci:minor_scheduler/setup
# Snapshot only the scheduler scores touched by start/timer tests, then isolate them.

execute store success score #ci.minor.had0 sgp.dummy store result score #ci.minor.saved0 sgp.dummy run scoreboard players get #events_mineurs_actifs sgp.dummy
execute store success score #ci.minor.had1 sgp.dummy store result score #ci.minor.saved1 sgp.dummy run scoreboard players get #events_mineurs sgp.timer
execute store success score #ci.minor.had2 sgp.dummy store result score #ci.minor.saved2 sgp.dummy run scoreboard players get #events_mineurs_seconds sgp.timer
execute store success score #ci.minor.had3 sgp.dummy store result score #ci.minor.saved3 sgp.dummy run scoreboard players get #random_event_timer_roll sgp.dummy
execute store success score #ci.minor.had4 sgp.dummy store result score #ci.minor.saved4 sgp.dummy run scoreboard players get #random_event_timer_roll_minus_60 sgp.dummy

scoreboard players set #events_mineurs_actifs sgp.dummy 0
scoreboard players set #events_mineurs sgp.timer 0
scoreboard players set #events_mineurs_seconds sgp.timer 0
scoreboard players set #random_event_timer_roll sgp.dummy 1000
scoreboard players set #random_event_timer_roll_minus_60 sgp.dummy 940
