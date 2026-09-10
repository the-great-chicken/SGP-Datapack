#> sgp.world:climbing_boost/custom_gravity
# @dummy
# @environment sgp.ci:climbing_boost
#
# Leaving a climb restores custom base gravity and another modifier.

function sgp.ci:climbing_boost/fixture
attribute @s minecraft:gravity base set 0.12
attribute @s minecraft:gravity modifier add sgp.ci:gravity 0.03 add_value
function sgp.world:climbing_boost/add
function sgp.ci:climbing_boost/expect_gravity {range:"0"}
assert entity @s[tag=sgp.climbing]
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"14999..15001"}
assert not entity @s[tag=sgp.climbing]
attribute @s minecraft:gravity modifier remove sgp.ci:gravity
function sgp.ci:climbing_boost/expect_gravity {range:"11999..12001"}
