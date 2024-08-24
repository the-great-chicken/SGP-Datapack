#> sgp.majeurs:hide_and_seek/died
#
# do the stuff when a player dies

advancement revoke @s only sgp.majeurs:death
tag @s remove sgp.hider

#verifie si il reste des Cacheurs en vie sinon on stop l'event
execute unless entity @e[team=sgp.hider] run title @a[tag=sgp.in_game] title [{"text": "Les Chasseur on gagné !", "color": "red"}]
execute unless entity @e[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/_stop

#check pour la team du joueur mort
scoreboard players operation #death_teams sgp.link_teams = @s sgp.link_teams
scoreboard players reset @s sgp.link_teams
execute as @a[team=] if score @s sgp.link_teams = #death_teams sgp.link_teams run tag @s add sgp.teammate_death
execute store result score #teammates_alive sgp.link_teams if entity @a[tag=sgp.teammate_death]
execute as @a[tag=sgp.teammate_death] run function sgp.majeurs:hide_and_seek/teams/lose_effect
tag @a remove sgp.teammate_death


#message de mort
tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"selector": "@s"},{"text": " de l'équipe "},{"score": {"name": "#death_teams","objective": "sgp.link_teams"}},{"text": " a été éliminée !"}]

execute if score #teammates_alive sgp.link_teams matches 0 run tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text": "l'équipe "},{"score": {"name": "#death_teams","objective": "sgp.link_teams"}},{"text": " a été éliminée !"}]

#actualise le joueur mort pour le switcher à la team des chasseurs
function sgp.majeurs:hide_and_seek/role/become_seeker