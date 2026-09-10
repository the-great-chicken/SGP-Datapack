#> sgp.diorama:weapon/existing_piercing
# @dummy
# @environment sgp.ci:diorama_weapon/existing_piercing

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.mainhand with diamond_sword[piercing_weapon={deals_knockback:true},enchantments={sharpness:2},custom_data={ci_keep:7}]
data modify storage sgp.ci:diorama_weapon original set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/expect_saved {key:original}
function sgp.ci:diorama_weapon/nearby
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_saved {key:original}
function sgp.ci:diorama_weapon/expect_piercing {present:1}
dummy WeaponOther leave
