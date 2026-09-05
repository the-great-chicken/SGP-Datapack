#> sgp.majeurs:common/eliminate
#
# Put one player in the shared eliminated/spectator state for the current round.

function #sgp.hooks:tgc/majeurs/common/eliminate_1
team leave @s
tag @s remove sgp.major_participant
tag @s add sgp.major_spectator
gamemode spectator @s
function #bs.schedule:schedule {run:"tp @s @e[tag=sgp.marker,name='pvp_arena',limit=1,type=marker]",with:{id:"major_event",time:2,unit:"t"}}
function #sgp.hooks:discord/majeurs/common/eliminate_1
