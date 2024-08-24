#> sgp.majeurs:hide_and_seek/_start
#
# Start the hide and seek game.

function sgp.majeurs:common/start

say 1
#calculate and atrivuate the seeker and hider
function sgp.misc:selected_player/main {div:10,tag:sgp.seeker,sign:"/"}
function sgp.misc:selected_player/main {div:3,tag:sgp.seeker,sign:"%"}

effect give @a[tag=sgp.in_game] minecraft:saturation infinite 1 true

execute as @a[tag=sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/seeker
execute as @a[tag=!sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/hider

say 2

title @a[tag=sgp.in_game] times 0t 22t 0t
#scoreboard players set @a[tag=sgp.in_game] sgp.timer 60

#make the teams of hiders
#execute store result storage sgp:data hide_and_seek.select_teams.selector int 1 run scoreboard players set #selector sgp.link_teams 1
#function sgp.majeurs:hide_and_seek/teams/select_teams

say 3

#start the timer
scoreboard players set #hider sgp.timer 60
scoreboard players set #seeker sgp.timer 60

function sgp.majeurs:hide_and_seek/timer/seeker
function sgp.majeurs:hide_and_seek/timer/hider
#function #bs.schedule:schedule {with:{command:"function sgp.majeurs:hide_and_seek/timer/hider",time:1,unit:"s"}}
say why

schedule function sgp.majeurs:hide_and_seek/_stop 300s