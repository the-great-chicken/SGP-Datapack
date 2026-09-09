#> sgp.ci:major_spectators/scenarios/arrival_isolation

dummy MajorPeer spawn
team join sgp.rouge MajorPeer
tag MajorPeer add sgp.major_participant
gamemode survival MajorPeer
function sgp.majeurs:common/spectator_join
assert entity @a[name=MajorPeer,team=sgp.rouge,gamemode=survival,tag=sgp.major_participant,tag=!sgp.major_spectator]
