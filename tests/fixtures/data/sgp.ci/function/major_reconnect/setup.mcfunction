#> sgp.ci:major_reconnect/setup
# Isolate stale-player repair from any event state left by another test.

function sgp.ci:players/cleanup
data modify storage sgp.ci:major_reconnect previous set value {}
execute store result storage sgp.ci:major_reconnect previous.protect_phase int 1 run scoreboard players get #protect_phase sgp.dummy
execute store result storage sgp.ci:major_reconnect previous.pco_phase int 1 run scoreboard players get #pco_phase sgp.dummy

scoreboard players set #protect_phase sgp.dummy 0
scoreboard players set #pco_phase sgp.dummy 0
team empty sgp.rouge
team empty sgp.bleue
team empty sgp.hider
team empty sgp.seeker
team empty sgp.Poule
team empty sgp.Canard
team empty sgp.Oie
