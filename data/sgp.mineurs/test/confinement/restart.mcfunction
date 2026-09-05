#> sgp.mineurs:confinement/restart
# @dummy
#
# Restarting Confinement gives a new grace period and still needs only one stop.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.confinement_restart set value {}
tag @s add sgp.in_game
gamemode survival @s
tp @s ~0.5 ~1 ~0.5
setblock ~ ~2 ~ minecraft:spruce_slab
function sgp.mineurs:confinement/start
function sgp.ci:minor_events/advance {function:"sgp.mineurs:confinement/running",ticks:20}
function sgp.mineurs:confinement/start
setblock ~ ~2 ~ minecraft:air
function sgp.ci:minor_events/advance {function:"sgp.mineurs:confinement/running",ticks:14}
execute store result storage sgp:data tests.confinement_restart.health int 1 run data get entity @s Health
function sgp.mineurs:confinement/stop
execute store result storage sgp:data tests.confinement_restart.active int 1 run scoreboard players get #timed_events_active sgp.dummy
schedule clear sgp.misc:second

assert data storage sgp:data tests.confinement_restart{health:20,active:0}
data remove storage sgp:data tests.confinement_restart
