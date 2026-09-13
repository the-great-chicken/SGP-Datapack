#> sgp.kits:water_enchantments/depth_strider/other_modifiers
# @dummy
# @environment sgp.ci:water_enchantments/depth_strider/other_modifiers
#
# The water bonus composes with another speed modifier and leaves it intact on exit.

function sgp.ci:water_enchantments/fixture
attribute @s minecraft:movement_speed modifier add sgp.ci:water_other 0.02 add_value
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"14999..15001",efficiency:"99999..100001"}
function sgp.ci:water_enchantments/dry
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"11999..12001",efficiency:"99999..100001"}
