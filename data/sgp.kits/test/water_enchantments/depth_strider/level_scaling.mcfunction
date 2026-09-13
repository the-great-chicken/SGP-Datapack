#> sgp.kits:water_enchantments/depth_strider/level_scaling
# @dummy
# @environment sgp.ci:water_enchantments/depth_strider/level_scaling
#
# Wading speed reflects enchantment level and remains independent between players.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
dummy WaterPeer spawn
gamemode survival WaterPeer
attribute WaterPeer minecraft:movement_speed base set 0.1
attribute WaterPeer minecraft:water_movement_efficiency base set 0
tp WaterPeer ~3.5 ~1 ~3.5
item replace entity WaterPeer armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":3}]
await delay 25t
function sgp.ci:water_enchantments/expect_movement {speed:"12999..13001",efficiency:"99999..100001"}
execute as WaterPeer run function sgp.ci:water_enchantments/expect_movement {speed:"14999..15001",efficiency:"99999..100001"}
