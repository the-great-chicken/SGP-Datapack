#> sgp.majeurs:hide_and_seek/_start
#
# Start the hide and seek game.

#calculate and atrivuate the seeker and hider
function sgp.misc:selected_player/main {div:10,tag:sgp.seeker,sign:"/"}
function sgp.misc:selected_player/main {div:3,tag:sgp.seeker,sign:"%"}

execute as @a[team=sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/seeker
execute as @a[team=!sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/hider



title @a[tag=sgp.in_game] times 0t 1s 0t
scoreboard players set @a[tag=sgp.in_game] sgp.timer 60

#make the teams of hiders
execute store result storage sgp:data hide_and_seek.select_teams.selector int 1 run scoreboard players set #selector sgp.link_teams 1
function sgp.majeurs:hide_and_seek/teams/select_teams

#start the timer
function sgp.majeurs:hide_and_seek/timer/seeker
function sgp.majeurs:hide_and_seek/timer/hider

schedule function sgp.majeurs:hide_and_seek/_stop 300s