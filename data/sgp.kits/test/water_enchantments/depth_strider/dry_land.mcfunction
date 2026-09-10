#> sgp.kits:water_enchantments/depth_strider/dry_land
# @dummy
# @environment sgp.ci:water_enchantments/depth_strider/dry_land
#
# Boots improve water movement efficiency without granting the wading speed bonus on land.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"9999..10001",efficiency:"99999..100001"}
