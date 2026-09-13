#> sgp.majeurs:common/spectator_join
#
# Let a mid-round arrival watch without joining the active round.

team leave @s
function #sgp.hooks:tgc/majeurs/common/spectator_join_1
tag @s add sgp.major_spectator
gamemode spectator @s
function #sgp.hooks:discord/majeurs/common/spectator_join_1
tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Une manche est déjà en cours : tu es en spectateur jusqu'à la prochaine.", color:yellow}]
