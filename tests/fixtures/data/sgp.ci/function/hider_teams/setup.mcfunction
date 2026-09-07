#> sgp.ci:hider_teams/setup

function sgp.ci:players/cleanup
execute store result storage sgp.ci:hider_teams previous_selector int 1 run scoreboard players get #selector sgp.link_teams
