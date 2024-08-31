#> sgp.majeurs:hide_and_seek/died
#
# do the stuff when a player dies

execute as @s[team=sgp.seeker] run function sgp.majeurs:hide_and_seek/role/effect/seeker
execute as @s[team=sgp.seeker] run return run tp @s @e[type=marker,tag=sgp.marker,name=spawn_seeker,limit=1]

#message de mort
tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"selector": "@s"},{"text": " de l'équipe "},{"score": {"name": "#death_teams","objective": "sgp.link_teams"}},{"text": " a été éliminé !"}]

execute if score #teammates_alive sgp.link_teams matches 0 run tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text": "l'équipe "},{"score": {"name": "#death_teams","objective": "sgp.link_teams"}},{"text": " a été éliminé !"}]

tag @s remove sgp.hider
team leave @s

#verifie si il reste des Cacheurs en vie sinon on stop l'event
execute unless entity @e[team=sgp.hider] run title @a[tag=sgp.in_game] title [{"text": "Les Chasseur gagne !", "color": "red"}]
execute unless entity @e[team=sgp.hider] run tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text": "Les ","color": "gold"},{"text":"Chasseurs ","color": "dark_green"}, {"text":"ont gagné ! Ils ont tué toute la","color": "gold"},{"text": " Volaille", "color": "yellow"}]
execute unless entity @e[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/_stop

#check pour la team du joueur mort
scoreboard players operation #death_teams sgp.link_teams = @s sgp.link_teams
scoreboard players reset @s sgp.link_teams
execute as @a[team=sgp.hider] if score @s sgp.link_teams = #death_teams sgp.link_teams run tag @s add sgp.teammate_death
execute store result score #teammates_alive sgp.link_teams if entity @a[tag=sgp.teammate_death]
execute as @a[tag=sgp.teammate_death] run function sgp.majeurs:hide_and_seek/teams/lose_effect
tag @a remove sgp.teammate_death

#tellraw @a {"score": {"name": "#teammates_alive","objective": "sgp.link_teams"}}



#actualise le joueur mort pour le switcher à la team des chasseurs
function sgp.majeurs:hide_and_seek/role/become_seeker
