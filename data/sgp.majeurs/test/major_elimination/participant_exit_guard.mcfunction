#> sgp.majeurs:major_elimination/participant_exit_guard
# @dummy
# @environment sgp.ci:major_elimination/participant_exit_guard
#
# The generic exit path leaves a non-participant alone when no event-specific handler owns them.

team leave @s
tag @s remove sgp.major_participant
tag @s remove sgp.major_spectator
gamemode survival @s
item replace entity @s weapon.mainhand with minecraft:diamond 3

function sgp.majeurs:common/participant_exit

assert entity @s[gamemode=survival,team=,tag=!sgp.major_participant,tag=!sgp.major_spectator]
execute store result score #ci.major.items sgp.dummy run clear @s minecraft:diamond 0
assert score #ci.major.items sgp.dummy matches 3
