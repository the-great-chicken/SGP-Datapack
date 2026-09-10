#> sgp.world:climbing_boost/honey_overlap
# @dummy
# @environment sgp.ci:climbing_boost
#
# Ending either movement boost preserves the other, then restores normal gravity.

function sgp.ci:climbing_boost/fixture
setblock ~4 ~1 ~3 honey_block
tp @s ~3.8 ~1 ~3.5
function sgp.world:climbing_boost/add
execute at @s run function sgp.world:slide_honey_up/add
assert entity @s[tag=sgp.climbing,tag=sgp.sliding_up]
function sgp.ci:climbing_boost/expect_gravity {range:"0"}
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"-1201..-1199"}
assert entity @s[tag=!sgp.climbing,tag=sgp.sliding_up]
function sgp.world:climbing_boost/add
function sgp.world:slide_honey_up/remove
function sgp.ci:climbing_boost/expect_gravity {range:"0"}
assert entity @s[tag=sgp.climbing,tag=!sgp.sliding_up]
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"7999..8001"}
