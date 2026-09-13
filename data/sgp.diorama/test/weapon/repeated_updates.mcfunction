#> sgp.diorama:weapon/repeated_updates
# @dummy
# @environment sgp.ci:diorama_weapon/repeated_updates

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.mainhand with diamond_sword[enchantments={sharpness:3},custom_data={ci_keep:4}]
function sgp.diorama:left_click/add_piercing_weapon
data modify storage sgp.ci:diorama_weapon enabled set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/expect_saved {key:enabled}
function sgp.ci:diorama_weapon/nearby
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:0}
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/expect_saved {key:enabled}
dummy WeaponOther leave
