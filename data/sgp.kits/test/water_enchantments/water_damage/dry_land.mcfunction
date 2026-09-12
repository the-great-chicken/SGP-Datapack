#> sgp.kits:water_enchantments/water_damage/dry_land
# @dummy
# @environment sgp.ci:water_enchantments/water_damage/dry_land
#
# The enchanted head applies no water penalties on dry land.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
await delay 25t
function sgp.ci:water_enchantments/expect_no_penalty
