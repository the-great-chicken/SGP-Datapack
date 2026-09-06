#> sgp.misc:kill_streaks/record_progression
# @dummy
#
# A new player's best starts at zero, increases with their streak, and never falls when later streaks are lower.

tag @s add sgp.in_game
scoreboard players reset @s sgp.plus_grande_streak
scoreboard players reset @s sgp.streak_en_cours
scoreboard players reset @s sgp.streak_reset
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 0

scoreboard players set @s sgp.streak_en_cours 3
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 3
assert score @s sgp.streak_en_cours matches 3

scoreboard players set @s sgp.streak_en_cours 8
function sgp.misc:kill_streaks_management
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 8
assert score @s sgp.streak_en_cours matches 8

scoreboard players set @s sgp.streak_en_cours 2
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 8
assert score @s sgp.streak_en_cours matches 2
tag @s remove sgp.in_game
