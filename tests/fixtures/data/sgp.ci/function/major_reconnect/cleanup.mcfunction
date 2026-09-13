#> sgp.ci:major_reconnect/cleanup
# Remove test players/teams and restore phase counters.

team empty sgp.rouge
team empty sgp.bleue
team empty sgp.hider
team empty sgp.seeker
team empty sgp.Poule
team empty sgp.Canard
team empty sgp.Oie
function sgp.ci:players/cleanup

execute store result score #protect_phase sgp.dummy run data get storage sgp.ci:major_reconnect previous.protect_phase
execute store result score #pco_phase sgp.dummy run data get storage sgp.ci:major_reconnect previous.pco_phase
data remove storage sgp.ci:major_reconnect previous
