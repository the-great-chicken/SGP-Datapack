#> sgp.majeurs:hide_and_seek/teams/apply_lost_effects
#
# Applies the hider penalties caused by dead teammates.

execute if score @s sgp.teammate_deaths matches 1.. run effect clear @s jump_boost
execute if score @s sgp.teammate_deaths matches 2.. run effect clear @s speed