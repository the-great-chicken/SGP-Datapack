#> sgp.majeurs:hide_and_seek/teams/select_teams
#
# select the teams for the hider

execute as @a[tag=!sgp.hider,team=sgp.hider,limit=3,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player

tellraw @a[tag=sgp.current_team] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes avec : "},{"selector":"@a[tag=sgp.current_team]"}]

execute store result storage sgp:data hide_and_seek.select_teams.selector int 1 run scoreboard players add #selector sgp.link_teams 1

tag @a[tag=sgp.current_team] remove sgp.current_team
execute if entity @a[team=sgp.hider,tag=!sgp.hider] run function sgp.majeurs:hide_and_seek/teams/select_teams