#> sgp.ci:major_spectators/scenarios/arrival

team join sgp.rouge @s
gamemode survival @s
function sgp.majeurs:common/spectator_join
assert entity @s[gamemode=spectator,tag=sgp.major_spectator,tag=!sgp.major_participant,team=]
