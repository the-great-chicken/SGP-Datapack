#> sgp.world:honey_climbing/modifier_lifecycle
# @dummy
# @environment sgp.ci:honey_climbing
#
# Leaving and re-entering preserves another gravity modifier and does not accumulate boosts.

function sgp.ci:honey_climbing/fixture
attribute @s minecraft:gravity modifier add sgp.ci:gravity 0.04 add_value
setblock ~4 ~1 ~3 honey_block
tp @s ~3.8 ~1 ~3.5
execute at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_gravity {range:"-1801..-1799"}
function sgp.world:slide_honey_up/remove
assert not entity @s[tag=sgp.sliding_up]
function sgp.ci:honey_climbing/expect_gravity {range:"11999..12001"}
execute at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_gravity {range:"-1801..-1799"}
function sgp.world:slide_honey_up/remove
function sgp.ci:honey_climbing/expect_gravity {range:"11999..12001"}
attribute @s minecraft:gravity modifier remove sgp.ci:gravity
function sgp.ci:honey_climbing/expect_gravity {range:"7999..8001"}
