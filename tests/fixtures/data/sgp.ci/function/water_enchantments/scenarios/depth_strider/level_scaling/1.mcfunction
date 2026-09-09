#> sgp.ci:water_enchantments/scenarios/depth_strider/level_scaling/1

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":1}]
function sgp.ci:water_enchantments/wet
dummy WaterPeer spawn
gamemode survival WaterPeer
attribute WaterPeer minecraft:movement_speed base set 0.1
attribute WaterPeer minecraft:water_movement_efficiency base set 0
tp WaterPeer ~3.5 ~1 ~3.5
item replace entity WaterPeer armor.feet with leather_boots[enchantments={"sgp.kits:depth_strider_boosted":3}]
