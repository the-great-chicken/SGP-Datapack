#> sgp.mineurs:common/choose_event
# 
# Roll a random number to choose a minor event to start

execute store result score #random_event_roll sgp.dummy run random value 1..4
execute if score #random_event_roll sgp.dummy matches 1 run function sgp.mineurs:magic/start
execute if score #random_event_roll sgp.dummy matches 2 run function sgp.mineurs:confinement/start
execute if score #random_event_roll sgp.dummy matches 3 run function sgp.mineurs:swap/start
execute if score #random_event_roll sgp.dummy matches 4 run function sgp.mineurs:reflexes/start


execute at @n[type=marker,tag=sgp.marker,name="pvp_arena"] run playsound minecraft:entity.experience_orb.pickup master @a[tag=sgp.in_game] ~ ~ ~ 100

execute store result score #random_event_timer_roll sgp.dummy run random value 3..5
scoreboard players operation #random_event_timer_roll_minus_1 sgp.dummy = #random_event_timer_roll sgp.dummy
scoreboard players operation #random_event_timer_roll_minus_1 sgp.dummy -= 1 sgp.dummy

scoreboard players set #events_mineurs_minutes sgp.timer 0