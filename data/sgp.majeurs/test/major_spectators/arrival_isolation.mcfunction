#> sgp.majeurs:major_spectators/arrival_isolation
# @dummy
# @environment sgp.ci:major_spectators/arrival_isolation
#
# An arriving spectator does not change an active competitor's team or mode.

dummy MajorPeer spawn
team join sgp.rouge MajorPeer
tag MajorPeer add sgp.major_participant
gamemode survival MajorPeer
function sgp.majeurs:common/spectator_join
assert entity @a[name=MajorPeer,team=sgp.rouge,gamemode=survival,tag=sgp.major_participant,tag=!sgp.major_spectator]
