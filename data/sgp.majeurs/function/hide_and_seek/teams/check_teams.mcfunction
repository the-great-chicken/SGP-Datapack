scoreboard players operation #death_teams sgp.link_teams = @s sgp.link_teams
scoreboard players reset @s sgp.link_teams
execute as @a[team=sgp.hider] if score @s sgp.link_teams = #death_teams sgp.link_teams run tag @s add sgp.teammate_death
execute store result score #teammates_alive sgp.link_teams if entity @a[tag=sgp.teammate_death]
execute as @a[tag=sgp.teammate_death] run function sgp.majeurs:hide_and_seek/teams/lose_effect
tag @a remove sgp.teammate_death