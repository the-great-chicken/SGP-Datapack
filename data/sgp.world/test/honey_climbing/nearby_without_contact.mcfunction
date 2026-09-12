#> sgp.world:honey_climbing/nearby_without_contact
# @dummy
# @environment sgp.ci:honey_climbing
#
# Nearby honey does not activate the boost while the player remains away from its surface.

function sgp.ci:honey_climbing/fixture
setblock ~4 ~1 ~3 honey_block
setblock ~4 ~2 ~3 honey_block
tp @s ~3.5 ~1 ~3.5
execute at @s run function sgp.world:slide_honey_up/add
assert not entity @s[tag=sgp.sliding_up]
function sgp.ci:honey_climbing/expect_gravity {range:"7999..8001"}
assert not entity @e[tag=sgp.vel_reset,distance=..8,type=armor_stand]
