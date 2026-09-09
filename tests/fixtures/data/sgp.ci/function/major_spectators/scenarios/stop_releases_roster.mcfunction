#> sgp.ci:major_spectators/scenarios/stop_releases_roster

tag @s add sgp.major_participant
team join sgp.rouge @s
gamemode adventure @s
experience set @s 8 levels
dummy MajorPeer spawn
tag MajorPeer add sgp.major_spectator
team join sgp.bleue MajorPeer
gamemode spectator MajorPeer
experience set MajorPeer 9 levels
assert entity @s[team=sgp.rouge,tag=sgp.major_participant]
assert entity @a[name=MajorPeer,team=sgp.bleue,tag=sgp.major_spectator]
function sgp.majeurs:common/stop
assert entity @s[gamemode=survival,team=,tag=!sgp.major_participant,tag=!sgp.major_spectator]
assert entity @a[name=MajorPeer,gamemode=survival,team=,tag=!sgp.major_participant,tag=!sgp.major_spectator]
execute store result score #ci.major.xp sgp.dummy run experience query @s levels
assert score #ci.major.xp sgp.dummy matches 0
execute store result score #ci.major.xp sgp.dummy run experience query MajorPeer levels
assert score #ci.major.xp sgp.dummy matches 0
