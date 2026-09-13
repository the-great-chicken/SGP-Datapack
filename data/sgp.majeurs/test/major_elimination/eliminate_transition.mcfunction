#> sgp.majeurs:major_elimination/eliminate_transition
# @dummy
# @environment sgp.ci:major_elimination/eliminate_transition
#
# Eliminating one participant moves only that player into the shared major-event spectator state.

team join sgp.rouge @s
tag @s add sgp.major_participant
tag @s remove sgp.major_spectator
gamemode survival @s

function sgp.majeurs:common/eliminate

assert entity @s[gamemode=spectator,team=,tag=!sgp.major_participant,tag=sgp.major_spectator]
