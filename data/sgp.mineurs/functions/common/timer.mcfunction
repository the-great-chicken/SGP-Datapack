#> sgp.mineurs:common/timer
# 
# Timer to execute a minor event every x minutes (x is random and changed each time)

scoreboard players add #events_mineurs sgp.timer 1

# Passage à la minute supérieure
execute if score #events_mineurs sgp.timer matches 600 run scoreboard players add #events_mineurs_minutes sgp.timer 1 
execute if score #events_mineurs sgp.timer matches 600 run scoreboard players set #events_mineurs sgp.timer 0

# Event Mineur
execute if score #events_mineurs_minutes sgp.timer = #random_event_timer_roll sgp.dummy run function sgp.mineurs:common/choose_event

# Lootdrop 1 minute avant l'event mineur
execute if score #events_mineurs_minutes sgp.timer = #random_event_timer_roll_minus_1 sgp.dummy if score #events_mineurs sgp.timer matches 0 run function sgp.mineurs:lootdrop/start