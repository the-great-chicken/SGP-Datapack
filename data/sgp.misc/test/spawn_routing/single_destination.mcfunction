#> sgp.misc:spawn_routing/single_destination
# @dummy
# @environment sgp.ci:spawn_routing
#
# A one-entry destination list preserves fractional position, facing, and the player's carried items.

function sgp.ci:spawn_routing/fixture
item replace entity @s weapon.mainhand with diamond 3
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~4.25 ~1 ~0.75 run assert entity @s[distance=..0.01]
function sgp.ci:spawn_routing/expect_facing {yaw:90,pitch:15}
execute store result score @s sgp.dummy run clear @s diamond 0
assert score @s sgp.dummy matches 3
