#> sgp.majeurs:hide_and_seek/timer/hider
#
# This function is called every second to update the timer of the hider.

execute if score #teammates_alive sgp.link_teams matches 2 run effect clear @s jump_boost
execute if score #teammates_alive sgp.link_teams matches 1 run effect clear @s speed