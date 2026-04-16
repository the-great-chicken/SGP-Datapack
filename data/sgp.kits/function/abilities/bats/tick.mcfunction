#> abilities/bats/tick
#
# Only restore equipment of players whose ability just ended

execute unless score @s sgp.duration_ability matches 1 run return 1

function sgp.kits:abilities/bats/end