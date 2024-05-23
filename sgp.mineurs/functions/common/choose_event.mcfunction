execute store result score #random_event_roll sgp.dummy run random value 1..4
execute if score #random_event_roll sgp.dummy matches 1 run function sgp.mineurs:magic/start
execute if score #random_event_roll sgp.dummy matches 2 run function sgp.mineurs:confinement/start
execute if score #random_event_roll sgp.dummy matches 3 run function sgp.mineurs:swap/start
execute if score #random_event_roll sgp.dummy matches 4 run function sgp.mineurs:reflexes/start