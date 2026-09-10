#> sgp.ci:hider_teams/cleanup
# Cancel Hide and Seek scheduling, remove fixture players, and restore all saved round/timer scores.

function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
schedule clear sgp.majeurs:hide_and_seek/timer/hider
schedule clear sgp.majeurs:hide_and_seek/timer/seeker
kill @e[tag=sgp.ci.hider_teams,type=marker]
function sgp.ci:players/cleanup
execute store result score #selector sgp.link_teams run data get storage sgp.ci:hider_teams previous_selector
execute store result score #hider sgp.timer run data get storage sgp.ci:hider_teams previous_hider_timer
execute store result score #seeker sgp.timer run data get storage sgp.ci:hider_teams previous_seeker_timer
execute store result score #rounds sgp.dummy run data get storage sgp.ci:hider_teams previous_rounds
execute store result score #hide_and_seek_max_rounds sgp.dummy run data get storage sgp.ci:hider_teams previous_max_rounds
execute store result score #second sgp.timer run data get storage sgp.ci:hider_teams previous_seconds
data remove storage sgp.ci:hider_teams previous_selector
data remove storage sgp.ci:hider_teams previous_hider_timer
data remove storage sgp.ci:hider_teams previous_seeker_timer
data remove storage sgp.ci:hider_teams previous_rounds
data remove storage sgp.ci:hider_teams previous_max_rounds
data remove storage sgp.ci:hider_teams previous_seconds
