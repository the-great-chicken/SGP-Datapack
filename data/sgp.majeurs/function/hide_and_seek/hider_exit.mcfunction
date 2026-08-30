#> sgp.majeurs:hide_and_seek/hider_exit

tag @s remove sgp.hider
team leave @s
function sgp.majeurs:hide_and_seek/teams/check_teams
tellraw @a[tag=sgp.in_game] [{storage:"sgp:text",nbt:"prefix",interpret:true},{selector:"@s"},{text:" de l'équipe "},{score:{name:"#death_in_team",objective:"sgp.link_teams"}},{text:" a quitté l'arène et est éliminé(e) !"}]
execute if score #teammates_alive sgp.link_teams matches 0 run tellraw @a[tag=sgp.in_game] [{storage:"sgp:text",nbt:"prefix",interpret:true},{text:"L'équipe "},{score:{name:"#death_in_team",objective:"sgp.link_teams"}},{text:" est éliminée !"}]
function sgp.majeurs:hide_and_seek/reset_player
function sgp.majeurs:common/eliminate_exit
execute unless entity @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/hiders_eliminated
