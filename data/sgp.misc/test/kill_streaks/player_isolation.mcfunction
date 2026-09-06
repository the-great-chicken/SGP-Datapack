#> sgp.misc:kill_streaks/player_isolation
# @dummy
#
# Deaths reset only the affected streaks, and out-of-game kills do not increase the record even when a death is pending.

tag @s add sgp.in_game
scoreboard players set @s sgp.plus_grande_streak 4
scoreboard players set @s sgp.streak_en_cours 6
scoreboard players set @s sgp.streak_reset 0
dummy StreakOther spawn
tag StreakOther add sgp.in_game
scoreboard players set StreakOther sgp.plus_grande_streak 3
scoreboard players set StreakOther sgp.streak_en_cours 7
scoreboard players set StreakOther sgp.streak_reset 1
dummy StreakOutside spawn
tag StreakOutside remove sgp.in_game
scoreboard players set StreakOutside sgp.plus_grande_streak 8
scoreboard players set StreakOutside sgp.streak_en_cours 12
scoreboard players set StreakOutside sgp.streak_reset 2

function sgp.misc:kill_streaks_management
execute store result storage sgp:data tests.streak_players.first_best int 1 run scoreboard players get @s sgp.plus_grande_streak
execute store result storage sgp:data tests.streak_players.first_current int 1 run scoreboard players get @s sgp.streak_en_cours
execute store result storage sgp:data tests.streak_players.other_best int 1 run scoreboard players get StreakOther sgp.plus_grande_streak
execute store result storage sgp:data tests.streak_players.other_current int 1 run scoreboard players get StreakOther sgp.streak_en_cours
execute store result storage sgp:data tests.streak_players.outside_best int 1 run scoreboard players get StreakOutside sgp.plus_grande_streak
execute store result storage sgp:data tests.streak_players.outside_current int 1 run scoreboard players get StreakOutside sgp.streak_en_cours

scoreboard players set StreakOutside sgp.streak_en_cours 1
function sgp.misc:kill_streaks_management
execute store result storage sgp:data tests.streak_players.outside_next int 1 run scoreboard players get StreakOutside sgp.streak_en_cours
dummy StreakOther leave
dummy StreakOutside leave
tag @s remove sgp.in_game

assert data storage sgp:data tests.streak_players{first_best:6,first_current:6,other_best:7,other_current:0,outside_best:8,outside_current:0,outside_next:1}
data remove storage sgp:data tests.streak_players
