#> sgp.majeurs:common/eliminate
#
# Put one player in the shared eliminated/spectator state for the current round.

glow remove @s
team leave @s
tag @s remove sgp.major_participant
tag @s add sgp.major_spectator
gamemode spectator @s
function #bs.schedule:schedule {run:"tp @s @e[type=marker,tag=sgp.marker,name='pvp_arena',limit=1]",with:{time:2,unit:"t"}}
move @s #Morts
