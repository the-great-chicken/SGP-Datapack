#> sgp.ci:water_enchantments/scenarios/water_damage/equipment_and_player_isolation/1

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
function sgp.ci:water_enchantments/wet
dummy WaterPeer spawn
gamemode survival WaterPeer
tp WaterPeer ~3.5 ~1 ~3.5
item replace entity WaterPeer weapon.mainhand with player_head[enchantments={"sgp.kits:water_damage":1}]
