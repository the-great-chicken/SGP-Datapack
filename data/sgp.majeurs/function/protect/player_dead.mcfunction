#> sgp.majeurs:protect/player_dead
#
# Teleport a player and other things when they die definitely

team leave @s
move @s #Morts
gamemode spectator @s
tp @s @e[type=marker,tag=sgp.marker,name="pvp_arena",limit=1]