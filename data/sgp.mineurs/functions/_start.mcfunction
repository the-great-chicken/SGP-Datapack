tellraw @a[tag=in_game] [{"text":"Activation des Événements Mineurs", "color":"green", "bold":true}]
scoreboard players set #events_mineurs_actifs sgp.dummy 1
scoreboard players set #events_mineurs sgp.timer 0
scoreboard players set #events_mineurs_minutes sgp.timer 0

execute store result score #random_event_timer_roll sgp.dummy run random value 3..5
scoreboard players operation #random_event_timer_roll_minus_1 sgp.dummy = #random_event_timer_roll sgp.dummy
scoreboard players operation #random_event_timer_roll_minus_1 sgp.dummy -= 1 sgp.dummy