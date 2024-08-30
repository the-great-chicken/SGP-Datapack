#> sgp.majeurs:hide_and_seek/_start
#
# Start the hide and seek game.

function sgp.majeurs:common/start

#calculate and atrivuate the seeker and hider
function sgp.misc:selected_player/main {div:10,tag:sgp.seeker,sign:"/"}
function sgp.misc:selected_player/main {div:3,tag:sgp.seeker,sign:"%"}

effect give @a[tag=sgp.in_game] minecraft:saturation infinite 1 true
execute as @a[tag=sgp.in_game] run attribute @s generic.water_movement_efficiency modifier add sgp.all 1 add_value

experience set @a[tag=sgp.in_game] 360 levels
experience set @a[tag=sgp.in_game] 100000 points
function sgp.majeurs:hide_and_seek/timer/second

execute as @a[tag=sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/seeker
execute as @a[tag=!sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/hider

title @a[tag=sgp.in_game] times 0t 22t 0t
#scoreboard players set @a[tag=sgp.in_game] sgp.timer 60

#make the teams of hiders
execute store result storage sgp:data hide_and_seek.select_teams.selector int 1 run scoreboard players set #selector sgp.link_teams 1
function sgp.majeurs:hide_and_seek/teams/select_teams

#start the timer
scoreboard players set #hider sgp.timer 60
scoreboard players set #seeker sgp.timer 60

function sgp.majeurs:hide_and_seek/timer/seeker
function sgp.majeurs:hide_and_seek/timer/hider

schedule function sgp.majeurs:hide_and_seek/_stop 360s
schedule function sgp.majeurs:hide_and_seek/timer/glow 90s