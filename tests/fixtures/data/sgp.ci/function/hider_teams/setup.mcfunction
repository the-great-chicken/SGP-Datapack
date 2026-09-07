#> sgp.ci:hider_teams/setup

function sgp.ci:players/cleanup
execute store result storage sgp.ci:hider_teams previous_selector int 1 run scoreboard players get #selector sgp.link_teams
execute store result storage sgp.ci:hider_teams previous_hider_timer int 1 run scoreboard players get #hider sgp.timer
execute store result storage sgp.ci:hider_teams previous_seeker_timer int 1 run scoreboard players get #seeker sgp.timer
