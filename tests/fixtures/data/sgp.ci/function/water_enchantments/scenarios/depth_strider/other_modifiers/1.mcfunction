#> sgp.ci:water_enchantments/scenarios/depth_strider/other_modifiers/1

function sgp.ci:water_enchantments/fixture
attribute @s minecraft:movement_speed modifier add sgp.ci:water_other 0.02 add_value
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
