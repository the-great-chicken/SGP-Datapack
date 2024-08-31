#> sgp.majeurs:protect/player_dead
#
# Teleport a player and other things when they die definitely

removeglow @s
team leave @s
gamemode spectator @s
function #bs.schedule:schedule {with:{command:"tp @s @e[type=marker,tag=sgp.marker,name='pvp_arena',limit=1]",time:2,unit:"t"}}
move @s #Morts