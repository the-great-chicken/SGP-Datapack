#> sgp.mineurs:confinement/restart
# @dummy
# @environment sgp.ci:confinement/restart
#
# Restarting Confinement gives a new grace period and still needs only one stop.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.confinement_restart set value {}
gamemode survival @s
tp @s ~0.5 ~1 ~0.5
fill ~-1 ~1 ~-1 ~1 ~3 ~1 air
setblock ~ ~ ~ stone
# Wait for the dummy client-loading protection to expire before checking damage.
await delay 61t
tag @s add sgp.in_game
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
