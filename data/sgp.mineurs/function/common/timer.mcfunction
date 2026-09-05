#> sgp.mineurs:common/timer
# 
# Timer to execute a minor event every x seconds (x is random and changed each time)

scoreboard players add #events_mineurs sgp.timer 1

# Passage à la seconde supérieure
execute unless score #events_mineurs sgp.timer matches 10 run return 0
scoreboard players set #events_mineurs sgp.timer 0
scoreboard players add #events_mineurs_seconds sgp.timer 1

# Event Mineur
execute if score #events_mineurs_seconds sgp.timer = #random_event_timer_roll sgp.dummy \
    run function sgp.mineurs:common/start_events

# Lootdrop 1 minute avant l'event mineur
execute if score #events_mineurs_seconds sgp.timer = #random_event_timer_roll_minus_60 sgp.dummy \
    run function sgp.mineurs:lootdrop/start
