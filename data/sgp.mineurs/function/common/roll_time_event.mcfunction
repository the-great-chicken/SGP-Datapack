#> sgp.mineurs:common/roll_time_event
#
# Choose the time before the next round, and reset the timer

execute store result score #random_event_timer_roll sgp.dummy run random value 200..300
scoreboard players operation #random_event_timer_roll_minus_60 sgp.dummy = #random_event_timer_roll sgp.dummy
scoreboard players remove #random_event_timer_roll_minus_60 sgp.dummy 60