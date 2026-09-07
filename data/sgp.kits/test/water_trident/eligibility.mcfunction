#> sgp.kits:water_trident/eligibility
# @dummy
# @environment sgp.ci:water_trident
#
# Only an in-game Poseidon holding the ability item is updated; ordinary tridents and offhand items retain their enchantments.

function sgp.ci:water_trident/fixture
dummy WaterOther spawn
tag WaterOther add sgp.ci.water_actor
gamemode creative WaterOther
tp WaterOther ~4.5 ~1 ~0.5
item replace entity WaterOther weapon.mainhand with trident[custom_data={sgp.water_trident:true}]
tag WaterOther add sgp.in_game
function sgp.kits:abilities/water_trident/tick
execute as WaterOther run function sgp.ci:water_trident/expect_riptide {present:0}
tag WaterOther remove sgp.in_game
tag WaterOther add sgp.poseidon
function sgp.kits:abilities/water_trident/tick
execute as WaterOther run function sgp.ci:water_trident/expect_riptide {present:0}
tag WaterOther add sgp.in_game
function sgp.kits:abilities/water_trident/tick
execute as WaterOther run function sgp.ci:water_trident/expect_riptide {present:1}
function sgp.ci:water_trident/expect_riptide {present:0}

item replace entity @s weapon.mainhand with trident[enchantments={riptide:2}]
item replace entity @s weapon.offhand with trident[custom_data={sgp.water_trident:true},enchantments={riptide:1}]
function sgp.kits:abilities/water_trident/tick
execute store success score @s sgp.dummy if items entity @s weapon.mainhand trident[enchantments~[{enchantments:"minecraft:riptide",levels:2}]]
assert score @s sgp.dummy matches 1
execute store success score @s sgp.dummy if items entity @s weapon.offhand trident[enchantments~[{enchantments:"minecraft:riptide",levels:1}]]
assert score @s sgp.dummy matches 1
