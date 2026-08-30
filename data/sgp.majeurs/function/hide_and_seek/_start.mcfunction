#> sgp.majeurs:hide_and_seek/_start
#
# Start the hide and seek game.

function sgp.majeurs:common/start

# Select the seekers
function sgp.misc:selected_player/main {div:10, tag:sgp.seeker, sign:"/", add:1}

effect give @a[tag=sgp.major_participant] saturation infinite 1 true
execute as @a[tag=sgp.major_participant] run attribute @s water_movement_efficiency modifier add sgp:hide_and_seek.water_movement 1 add_value

function sgp.misc:timer_experience {duration:360}

execute as @a[tag=sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/seeker
execute as @a[tag=sgp.major_participant,tag=!sgp.seeker] at @s run function sgp.majeurs:hide_and_seek/role/hider

title @a[tag=sgp.major_participant] times 0t 22t 0t
#scoreboard players set @a[tag=sgp.in_game] sgp.timer 60

#make the teams of hiders
scoreboard players set #selector sgp.link_teams 1
function sgp.majeurs:hide_and_seek/teams/select_teams

#start the timer
scoreboard players set #hider sgp.timer 60
scoreboard players set #seeker sgp.timer 60

function sgp.majeurs:hide_and_seek/timer/seeker
function sgp.majeurs:hide_and_seek/timer/hider

schedule function sgp.majeurs:hide_and_seek/_stop 360s
schedule function sgp.majeurs:hide_and_seek/timer/glow_announce 80s
