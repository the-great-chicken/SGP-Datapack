#> sgp.kits:water_enchantments/depth_strider/unequip
# @dummy
# @environment sgp.ci:water_enchantments/depth_strider/unequip
#
# Removing the boots in water removes both their speed bonus and water movement efficiency.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"12999..13001",efficiency:"99999..100001"}
item replace entity @s armor.feet with air
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"9999..10001",efficiency:"0"}
