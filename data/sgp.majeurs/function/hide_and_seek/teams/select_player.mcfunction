#> sgp.majeurs:hide_and_seek/teams/select_teams
#
# select the teams for the hider

tag @s add sgp.hider
tag @s add sgp.current_team
scoreboard players operation @s sgp.link_teams = #selector sgp.link_teams
#function sgp.majeurs:hide_and_seek/teams/move