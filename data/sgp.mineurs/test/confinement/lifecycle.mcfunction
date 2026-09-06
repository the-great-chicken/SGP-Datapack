#> sgp.mineurs:confinement/lifecycle
# @dummy
# @environment sgp.ci:confinement/lifecycle
#
# Allow fourteen safe seconds, begin exposure damage at fifteen, and end at 150 seconds.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.confinement_lifecycle set value {}
gamemode survival @s
tp @s ~0.5 ~1 ~0.5
fill ~-1 ~1 ~-1 ~1 ~3 ~1 air
setblock ~ ~ ~ stone
# Wait for the dummy client-loading protection to expire before checking damage.
await delay 61t
tag @s add sgp.in_game
function sgp.mineurs:confinement/start
function sgp.ci:minor_events/advance {function:"sgp.mineurs:confinement/running",ticks:14}
execute store result storage sgp:data tests.confinement_lifecycle.grace int 1 run data get entity @s Health
function sgp.mineurs:confinement/running
execute store result storage sgp:data tests.confinement_lifecycle.exposed int 1 run data get entity @s Health
setblock ~ ~2 ~ minecraft:spruce_slab
function sgp.ci:minor_events/advance {function:"sgp.mineurs:confinement/running",ticks:135}
execute store result storage sgp:data tests.confinement_lifecycle.active int 1 run scoreboard players get #timed_events_active sgp.dummy
execute store success storage sgp:data tests.confinement_lifecycle.running byte 1 run schedule clear sgp.mineurs:confinement/running
execute store success storage sgp:data tests.confinement_lifecycle.clock byte 1 run schedule clear sgp.mineurs:confinement/add_time_clock
setblock ~ ~2 ~ minecraft:air
schedule clear sgp.misc:second

assert data storage sgp:data tests.confinement_lifecycle{grace:20,exposed:16,active:0,running:0b,clock:0b}
assert score #confines_secondes sgp.timer matches 0
data remove storage sgp:data tests.confinement_lifecycle
