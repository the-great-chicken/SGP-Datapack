#> sgp.diorama:weapon/existing_presentation
# @dummy
# @environment sgp.ci:diorama_weapon/existing_presentation
#
# Every temporary-state encoding must restore the complete original item exactly.

function sgp.ci:diorama_weapon/fixture

# State 1: pre-existing glint override and enchantment tooltip already hidden.
item replace entity @s weapon.mainhand with stick[enchantment_glint_override=false,tooltip_display={hidden_components:["enchantments","attribute_modifiers"]},custom_data={ci_keep:11}]
data modify storage sgp.ci:diorama_weapon state_1 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:1}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_1}

# State 2: Diorama creates only the glint override.
item replace entity @s weapon.mainhand with stick[tooltip_display={hidden_components:["enchantments"]},custom_data={ci_keep:12}]
data modify storage sgp.ci:diorama_weapon state_2 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:2}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_2}

# State 3: Diorama creates only tooltip_display.
item replace entity @s weapon.mainhand with diamond_sword[!tooltip_display,enchantments={sharpness:2},custom_data={ci_keep:13}]
data modify storage sgp.ci:diorama_weapon state_3 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:3}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_3}

# State 4: Diorama creates both glint override and tooltip_display.
item replace entity @s weapon.mainhand with stick[!tooltip_display,custom_data={ci_keep:14}]
data modify storage sgp.ci:diorama_weapon state_4 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:4}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_4}

# State 5: Diorama hides enchantments on an existing tooltip_display.
item replace entity @s weapon.mainhand with diamond_sword[enchantments={unbreaking:2},tooltip_display={hidden_components:["attribute_modifiers"]},custom_data={ci_keep:15}]
data modify storage sgp.ci:diorama_weapon state_5 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:5}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_5}

# State 6: Diorama creates the glint override and hides enchantments on an existing tooltip_display.
item replace entity @s weapon.mainhand with stick[tooltip_display={hidden_components:["attribute_modifiers"]},custom_data={ci_keep:16}]
data modify storage sgp.ci:diorama_weapon state_6 set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:6}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:state_6}

# Default tooltip_display is present even though it is omitted from item NBT.
item replace entity @s weapon.mainhand with diamond_sword[enchantments={sharpness:2},custom_data={ci_keep:17}]
data modify storage sgp.ci:diorama_weapon default_enchanted set from entity @s Inventory
assert items entity @s weapon.mainhand *[tooltip_display]
assert not data entity @s SelectedItem.components."minecraft:tooltip_display"
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:5}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:default_enchanted}

item replace entity @s weapon.mainhand with stick[custom_data={ci_keep:18}]
data modify storage sgp.ci:diorama_weapon default_unenchanted set from entity @s Inventory
function sgp.diorama:left_click/add_piercing_weapon
assert items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:6}]]
function sgp.diorama:left_click/restore_weapon
function sgp.ci:diorama_weapon/expect_saved {key:default_unenchanted}
