#> sgp.majeurs:major_spectators/stop_bystander
# @dummy
# @environment sgp.ci:major_spectators/stop_bystander
#
# Stopping a major event preserves unrelated players' mode, team, experience, and reward state.

tag @s add sgp.major_participant
dummy MajorPeer spawn
gamemode creative MajorPeer
team join sgp.hider MajorPeer
experience set MajorPeer 12 levels
scoreboard players set MajorPeer sgp.streak_en_cours 9
function sgp.majeurs:common/stop
function sgp.majeurs:common/stop
assert entity @a[name=MajorPeer,gamemode=creative,team=sgp.hider]
execute store result score #ci.major.xp sgp.dummy run experience query MajorPeer levels
assert score #ci.major.xp sgp.dummy matches 12
assert score MajorPeer sgp.streak_en_cours matches 9
