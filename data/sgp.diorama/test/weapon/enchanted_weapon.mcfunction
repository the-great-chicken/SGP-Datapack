#> sgp.diorama:weapon/enchanted_weapon
# @dummy
# @environment sgp.ci:diorama_weapon/enchanted_weapon

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.mainhand with diamond_sword[damage=17,enchantments={sharpness:3,unbreaking:2},enchantment_glint_override=true,tooltip_display={hidden_components:["attribute_modifiers"]},custom_data={ci_keep:9}]
data modify storage sgp.ci:diorama_weapon original set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:1}
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection"}]]
function sgp.ci:diorama_weapon/nearby
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:0}
function sgp.ci:diorama_weapon/expect_saved {key:original}
dummy WeaponOther leave
