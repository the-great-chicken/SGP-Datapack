#> sgp.majeurs:major_elimination/participant_exit_fallback
# @dummy
# @environment sgp.ci:major_elimination/participant_exit_fallback
#
# A participant whose event-specific team state is already gone still receives the generic exit elimination.

team leave @s
tag @s add sgp.major_participant
tag @s remove sgp.major_spectator
gamemode survival @s
scoreboard players set @s sgp.kit_id -1

function sgp.majeurs:common/participant_exit

assert entity @s[gamemode=spectator,team=,tag=!sgp.major_participant,tag=sgp.major_spectator]
assert chat ".*quitté l'arène et es éliminé.*" @s
