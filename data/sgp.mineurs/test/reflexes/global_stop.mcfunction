#> sgp.mineurs:reflexes/global_stop
# @dummy
#
# Disabling minor events cancels Reflexes and revokes its response button without punishing anyone.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.reflexes_stop set value {}
tag @s add sgp.in_game
function sgp.mineurs:reflexes/start
function sgp.mineurs:_stop
execute store success storage sgp:data tests.reflexes_stop.scheduled byte 1 run schedule clear sgp.mineurs:reflexes/running
execute store success storage sgp:data tests.reflexes_stop.can_respond byte 1 run trigger sgp.reflexes_joueur
execute store result storage sgp:data tests.reflexes_stop.punishment int 1 if entity @e[distance=..12,type=tnt]
kill @e[distance=..12,type=tnt]
schedule clear sgp.misc:second

assert data storage sgp:data tests.reflexes_stop{scheduled:0b,can_respond:0b,punishment:0}
data remove storage sgp:data tests.reflexes_stop
