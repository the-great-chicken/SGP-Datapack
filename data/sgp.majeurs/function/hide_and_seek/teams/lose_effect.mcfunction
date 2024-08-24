#> sgp.majeurs:hide_and_seek/timer/hider
#
# This function is called every second to update the timer of the hider.

execute if score #teammates_alive sgp.link_teams matches 2 run return run effect clear @s jump_boost
effect clear @s speed