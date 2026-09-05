#> sgp.majeurs:hide_and_seek/teams/select_teams
#
# Select hider teams.
# Default size is 4. Remainders are absorbed as:
#   +1 -> one team of 5
#   +2 -> two teams of 5, except 6 hiders -> two teams of 3
#   +3 -> one team of 3

execute store result score #hiders_remaining sgp.link_teams if entity @a[tag=!sgp.hider,team=sgp.hider]
execute unless score #hiders_remaining sgp.link_teams matches 1.. run return 0

scoreboard players operation #team_size sgp.link_teams = #hiders_remaining sgp.link_teams
execute if score #hiders_remaining sgp.link_teams matches 6.. run scoreboard players set #team_size sgp.link_teams 4

scoreboard players operation #hiders_remainder sgp.link_teams = #hiders_remaining sgp.link_teams
scoreboard players operation #hiders_remainder sgp.link_teams %= 4 sgp.dummy
execute if score #hiders_remaining sgp.link_teams matches 6.. if score #hiders_remainder sgp.link_teams matches 1 run scoreboard players set #team_size sgp.link_teams 5
execute if score #hiders_remaining sgp.link_teams matches 7.. if score #hiders_remainder sgp.link_teams matches 2 run scoreboard players set #team_size sgp.link_teams 5
execute if score #hiders_remaining sgp.link_teams matches 6 if score #hiders_remainder sgp.link_teams matches 2 run scoreboard players set #team_size sgp.link_teams 3

execute if score #team_size sgp.link_teams matches 1 as @a[tag=!sgp.hider,team=sgp.hider,limit=1,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player
execute if score #team_size sgp.link_teams matches 2 as @a[tag=!sgp.hider,team=sgp.hider,limit=2,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player
execute if score #team_size sgp.link_teams matches 3 as @a[tag=!sgp.hider,team=sgp.hider,limit=3,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player
execute if score #team_size sgp.link_teams matches 4 as @a[tag=!sgp.hider,team=sgp.hider,limit=4,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player
execute if score #team_size sgp.link_teams matches 5 as @a[tag=!sgp.hider,team=sgp.hider,limit=5,sort=random] at @s run function sgp.majeurs:hide_and_seek/teams/select_player

tellraw @a[tag=sgp.current_team] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Tu es avec : "}, {selector:"@a[tag=sgp.current_team]"}]

scoreboard players add #selector sgp.link_teams 1

tag @a[tag=sgp.current_team] remove sgp.current_team
execute if entity @a[team=sgp.hider,tag=!sgp.hider] run function sgp.majeurs:hide_and_seek/teams/select_teams