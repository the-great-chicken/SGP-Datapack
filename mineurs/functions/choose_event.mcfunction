execute store result score #random_event_roll dummy run random value 1..4
execute if score #random_event_roll dummy matches 1 run function mineurs:magic
execute if score #random_event_roll dummy matches 2 run function mineurs:confinement_start
execute if score #random_event_roll dummy matches 3 run function mineurs:swap
execute if score #random_event_roll dummy matches 4 run function mineurs:reflexes_start