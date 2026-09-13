#> sgp.majeurs:major_spectators/repeated_arrival
# @dummy
# @environment sgp.ci:major_spectators/repeated_arrival
#
# Repeated spectator entry preserves the same non-participant state.

function sgp.majeurs:common/spectator_join
function sgp.majeurs:common/spectator_join
assert entity @s[gamemode=spectator,tag=sgp.major_spectator,tag=!sgp.major_participant,team=]
