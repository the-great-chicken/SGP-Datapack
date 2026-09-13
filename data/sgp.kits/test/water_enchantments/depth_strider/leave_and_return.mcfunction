#> sgp.kits:water_enchantments/depth_strider/leave_and_return
# @dummy
# @environment sgp.ci:water_enchantments/depth_strider/leave_and_return
#
# Leaving water removes the speed bonus; returning restores it without stacking.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"12999..13001",efficiency:"99999..100001"}
function sgp.ci:water_enchantments/dry
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"9999..10001",efficiency:"99999..100001"}
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"12999..13001",efficiency:"99999..100001"}
