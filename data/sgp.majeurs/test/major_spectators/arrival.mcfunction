#> sgp.majeurs:major_spectators/arrival
# @dummy
# @environment sgp.ci:major_spectators/arrival
#
# A mid-round arrival becomes a spectator and leaves their former team.

team join sgp.rouge @s
gamemode survival @s
function sgp.majeurs:common/spectator_join
assert entity @s[gamemode=spectator,tag=sgp.major_spectator,tag=!sgp.major_participant,team=]
