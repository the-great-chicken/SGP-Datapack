#> sgp.kits:water_trident/riptide_lifecycle
# @dummy
# @environment sgp.ci:water_trident
#
# Water enables Riptide and dry land removes it, preserving the trident's durability, custom data, and other enchantments.

function sgp.ci:water_trident/fixture
function sgp.kits:abilities/water_trident/tick
function sgp.ci:water_trident/expect_riptide {present:0}
tp @s ~4.5 ~1 ~0.5
function sgp.kits:abilities/water_trident/tick
function sgp.ci:water_trident/expect_riptide {present:1}
function sgp.kits:abilities/water_trident/tick
tp @s ~0.5 ~1 ~0.5
function sgp.kits:abilities/water_trident/tick
function sgp.ci:water_trident/expect_riptide {present:0}
execute store success score @s sgp.dummy if items entity @s weapon.mainhand trident[damage=31,custom_data~{sgp.water_trident:true,ci_keep:7},enchantments~[{enchantments:"minecraft:unbreaking",levels:3}]]
assert score @s sgp.dummy matches 1
tp @s ~4.5 ~1 ~0.5
function sgp.kits:abilities/water_trident/tick
function sgp.ci:water_trident/expect_riptide {present:1}
