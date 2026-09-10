#> sgp.diorama:weapon/enchanted_weapon
# @dummy
# @environment sgp.ci:diorama_weapon/enchanted_weapon

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.mainhand with diamond_sword[damage=17,enchantments={sharpness:3,unbreaking:2},custom_data={ci_keep:9}]
function sgp.diorama:left_click/add_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:1}
assert entity @s[nbt={Inventory:[{id:"minecraft:diamond_sword",components:{"minecraft:damage":17,"minecraft:custom_data":{ci_keep:9},"minecraft:enchantments":{"minecraft:sharpness":3,"minecraft:unbreaking":2,"sgp.diorama:left_click_detection":1}}}]}]
function sgp.ci:diorama_weapon/nearby
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:0}
assert entity @s[nbt={Inventory:[{id:"minecraft:diamond_sword",components:{"minecraft:damage":17,"minecraft:custom_data":{ci_keep:9},"minecraft:enchantments":{"minecraft:sharpness":3,"minecraft:unbreaking":2}}}]}]
dummy WeaponOther leave
