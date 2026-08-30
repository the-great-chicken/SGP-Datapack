#> sgp.majeurs:hide_and_seek/died
#
# do the stuff when a player dies

execute unless entity @s[tag=sgp.major_participant] run return 0

# If a seeker dies, keep their current release state.
execute as @s[team=sgp.seeker] run function sgp.majeurs:hide_and_seek/role/equipment/seeker
execute as @s[team=sgp.seeker,tag=!sgp.seeker_waiting] run function sgp.majeurs:hide_and_seek/role/effect/seeker
execute as @s[team=sgp.seeker,tag=sgp.seeker_waiting] run function sgp.misc:stun/apply {duration:infinite}
execute as @s[team=sgp.seeker] run return run tp @s @e[type=marker,tag=sgp.marker,name=spawn_seeker,limit=1]

# Remove the dead hider from the living hider set before updating team state.
tag @s remove sgp.hider
team leave @s
function sgp.majeurs:hide_and_seek/teams/check_teams

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {selector:"@s"}, {text:" de l'équipe "}, {score:{name:"#death_in_team", objective:"sgp.link_teams"}}, {text:" a été éliminé(e) !"}]

execute if score #teammates_alive sgp.link_teams matches 0 \
    run tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"l'équipe "}, {score:{name:"#death_in_team", objective:"sgp.link_teams"}}, {text:" a été éliminée !"}]

#verifie si il reste des Cacheurs en vie sinon on stop l'event
execute unless entity @a[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/hiders_eliminated

#actualise le joueur mort pour le switcher à la team des chasseurs
function sgp.majeurs:hide_and_seek/role/become_seeker
