#> sgp.misc:kill_streaks/death_and_restart
# @dummy
#
# A first streak ending before initialization still becomes a record; consuming the death allows the next streak to grow.

tag @s add sgp.in_game
scoreboard players reset @s sgp.plus_grande_streak
scoreboard players set @s sgp.streak_en_cours 7
scoreboard players set @s sgp.streak_reset 1
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 7
assert score @s sgp.streak_en_cours matches 0

scoreboard players set @s sgp.streak_en_cours 3
function sgp.misc:kill_streaks_management
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 7
assert score @s sgp.streak_en_cours matches 3

scoreboard players set @s sgp.streak_reset 2
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 7
assert score @s sgp.streak_en_cours matches 0

scoreboard players set @s sgp.streak_en_cours 9
function sgp.misc:kill_streaks_management
assert score @s sgp.plus_grande_streak matches 9
assert score @s sgp.streak_en_cours matches 9
tag @s remove sgp.in_game
