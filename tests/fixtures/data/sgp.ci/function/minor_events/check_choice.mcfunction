#> sgp.ci:minor_events/check_choice
# `{nbr, roll, first, second, previous_count, previous_first, previous_second, previous_third}`
#
# Resolve a controlled roll and check eligibility without locking in which replacement is chosen.

$scoreboard players set #random_event_roll_1 sgp.dummy $(first)
$scoreboard players set #random_event_roll_2 sgp.dummy $(second)
$scoreboard players set #random_event_roll_$(nbr) sgp.dummy $(roll)
$scoreboard players set #last_nbr_events sgp.dummy $(previous_count)
$scoreboard players set #last_event_1 sgp.dummy $(previous_first)
$scoreboard players set #last_event_2 sgp.dummy $(previous_second)
$scoreboard players set #last_event_3 sgp.dummy $(previous_third)
$function sgp.mineurs:common/change_event_if_same {nbr:$(nbr)}
$assert score #random_event_roll_$(nbr) sgp.dummy matches 1..7
$assert not score #random_event_roll_$(nbr) sgp.dummy = #last_event_1 sgp.dummy
$execute if score #last_nbr_events sgp.dummy matches 2.. run function sgp.ci:minor_events/check_previous_second {nbr:$(nbr)}
$execute if score #last_nbr_events sgp.dummy matches 3.. run function sgp.ci:minor_events/check_previous_third {nbr:$(nbr)}
$execute if score $(nbr) sgp.dummy matches 2.. run function sgp.ci:minor_events/check_current_first {nbr:$(nbr)}
$execute if score $(nbr) sgp.dummy matches 3 run function sgp.ci:minor_events/check_current_second {nbr:$(nbr)}
