#> sgp.mineurs:reflexes/restart
# @dummy
#
# Restarting requires a fresh response instead of carrying over a previous click.

data modify storage sgp:data tests.reflexes_restart set value {}
tag @s add sgp.in_game
tp @s ~0.5 ~1 ~0.5
function sgp.mineurs:reflexes/start
trigger sgp.reflexes_joueur
function sgp.mineurs:reflexes/running
function sgp.mineurs:reflexes/start
function sgp.ci:minor_events/advance {function:"sgp.mineurs:reflexes/running",ticks:99}
execute store result storage sgp:data tests.reflexes_restart.punishment int 1 if entity @e[distance=..2,type=tnt]
kill @e[distance=..2,type=tnt]

assert data storage sgp:data tests.reflexes_restart{punishment:1}
data remove storage sgp:data tests.reflexes_restart
