#> sgp.majeurs:hide_and_seek/teams/check_teams
#
# Updates the linked-team state after @s, a hider, has died.
# This function must be called after @s has left team sgp.hider.

scoreboard players operation #death_in_team sgp.link_teams = @s sgp.link_teams
scoreboard players reset @s sgp.link_teams

execute as @a[team=sgp.hider] if score @s sgp.link_teams = #death_in_team sgp.link_teams \
    run tag @s add sgp.teammate_death

execute as @a[tag=sgp.teammate_death] \
    run scoreboard players add @s sgp.teammate_deaths 1

execute store result score #teammates_alive sgp.link_teams \
    if entity @a[tag=sgp.teammate_death]

execute as @a[tag=sgp.teammate_death] \
    run function sgp.majeurs:hide_and_seek/teams/apply_lost_effects

tag @a remove sgp.teammate_death