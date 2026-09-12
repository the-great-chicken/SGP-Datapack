#> sgp.mineurs:smol/lifecycle
# @dummy
#
# Halve participants' actual size, preserve unrelated modifiers, and restore players who leave before expiry.

function sgp.ci:minor_events/reset_timer
data modify storage sgp.ci:smol lifecycle set value {}
tag @s add sgp.in_game
attribute @s minecraft:scale base set 1
attribute @s minecraft:scale modifier add sgp:test_size 0.2 add_value
dummy SmolOutside spawn
attribute SmolOutside minecraft:scale base set 1
function sgp.mineurs:smol/start
execute store result storage sgp.ci:smol lifecycle.during int 1 run attribute @s minecraft:scale get 1000
execute store result storage sgp.ci:smol lifecycle.outside int 1 run attribute SmolOutside minecraft:scale get 1000
tag @s remove sgp.in_game
function sgp.mineurs:smol/end
execute store result storage sgp.ci:smol lifecycle.after int 1 run attribute @s minecraft:scale get 1000
function sgp.mineurs:smol/stop
execute store result storage sgp.ci:smol lifecycle.stopped_again int 1 run attribute @s minecraft:scale get 1000
dummy SmolOutside leave
schedule clear sgp.misc:second

assert data storage sgp.ci:smol lifecycle{during:600,outside:1000,after:1200,stopped_again:1200}
assert score #timed_events_active sgp.dummy matches 0
data remove storage sgp.ci:smol lifecycle
