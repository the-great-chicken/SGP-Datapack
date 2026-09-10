#> sgp.kits:water_enchantments/water_damage/leave_water
# @dummy
# @environment sgp.ci:water_enchantments/water_damage/leave_water
#
# After leaving water, existing penalties expire without being refreshed.

function sgp.ci:water_enchantments/fixture
item replace entity @s armor.head with player_head[enchantments={"sgp.kits:water_damage":1}]
function sgp.ci:water_enchantments/wet
await delay 25t
function sgp.ci:water_enchantments/expect_penalty
function sgp.ci:water_enchantments/dry
await delay 65t
function sgp.ci:water_enchantments/expect_no_penalty
