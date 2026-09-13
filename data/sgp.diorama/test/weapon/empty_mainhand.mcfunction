#> sgp.diorama:weapon/empty_mainhand
# @dummy
# @environment sgp.ci:diorama_weapon/empty_mainhand

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.offhand with diamond_sword[enchantments={sharpness:2}]
data modify storage sgp.ci:diorama_weapon original set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/nearby
function sgp.diorama:left_click/remove_piercing_weapon
execute store success score @s sgp.dummy if items entity @s weapon.mainhand *
assert score @s sgp.dummy matches 0
function sgp.ci:diorama_weapon/expect_saved {key:original}
execute store success score @s sgp.dummy if items entity @s weapon.offhand diamond_sword[enchantments~[{enchantments:"minecraft:sharpness",levels:2}]]
assert score @s sgp.dummy matches 1
dummy WeaponOther leave
