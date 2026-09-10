#> sgp.kits:water_enchantments/water_damage/unequip
# @dummy
# @environment sgp.ci:water_enchantments/water_damage/unequip
#
# Removing the enchanted head stops refreshing its penalties even while the player remains in water.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_penalty
item replace entity @s armor.head with air
await delay 65t
function sgp.ci:water_enchantments/expect_no_penalty
