#> sgp.kits:water_enchantments/water_damage/enter_water
# @dummy
# @environment sgp.ci:water_enchantments/water_damage/enter_water
#
# The enchanted head applies both penalties when its wearer enters water.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_penalty
