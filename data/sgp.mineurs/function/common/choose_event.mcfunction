#> sgp.mineurs:common/choose_event
# `{nbr: int}`
# 
# Roll a random number to choose a minor event to start


$execute store result score #random_event_roll_$(nbr) sgp.dummy \
    run random value 1..7

$function sgp.mineurs:common/change_event_if_same {nbr:$(nbr)}

$execute if score #random_event_roll_$(nbr) sgp.dummy matches 1 run function sgp.mineurs:magic/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 2 run function sgp.mineurs:confinement/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 3 run function sgp.mineurs:swap/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 4 run function sgp.mineurs:reflexes/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 5 run function sgp.mineurs:smol/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 6 run function sgp.mineurs:bounty/start
$execute if score #random_event_roll_$(nbr) sgp.dummy matches 7 run function sgp.mineurs:frenzy/start
