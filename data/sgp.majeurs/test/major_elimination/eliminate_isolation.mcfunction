#> sgp.majeurs:major_elimination/eliminate_isolation
# @dummy
# @environment sgp.ci:major_elimination/eliminate_isolation
#
# Eliminating one participant must not change another active participant's team, mode, or event tags.

team join sgp.rouge @s
tag @s add sgp.major_participant
gamemode survival @s

dummy MajorElimPeer spawn
team join sgp.bleue MajorElimPeer
tag MajorElimPeer add sgp.major_participant
tag MajorElimPeer remove sgp.major_spectator
gamemode survival MajorElimPeer

function sgp.majeurs:common/eliminate

assert entity @s[gamemode=spectator,team=,tag=!sgp.major_participant,tag=sgp.major_spectator]
assert entity @a[name=MajorElimPeer,gamemode=survival,team=sgp.bleue,tag=sgp.major_participant,tag=!sgp.major_spectator]
