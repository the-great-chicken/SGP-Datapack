#> sgp.kits:water_enchantments/water_damage/equipment_and_player_isolation
# @dummy
# @environment sgp.ci:water_enchantments/water_damage/equipment_and_player_isolation
#
# An equipped head affects its wearer; a nearby player merely holding it stays unaffected.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
function sgp.ci:water_enchantments/wet
dummy WaterPeer spawn
gamemode survival WaterPeer
tp WaterPeer ~3.5 ~1 ~3.5
item replace entity WaterPeer weapon.mainhand with player_head[enchantments={"sgp.kits:water_damage":1}]
await delay 25t
function sgp.ci:water_enchantments/expect_penalty
execute as WaterPeer run function sgp.ci:water_enchantments/expect_no_penalty
