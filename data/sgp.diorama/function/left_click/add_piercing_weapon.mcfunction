#> sgp.diorama:left_click/add_piercing_weapon
#
# Checks if the player lacks piercing weapon for left click detect,
# and provides it if so. The temporary enchantment level records exactly which
# presentation components Diorama introduced so cleanup can restore the item.

execute unless items entity @s weapon.mainhand *[!piercing_weapon] run return 1

# State encoded in the temporary enchantment level:
# 1: no presentation state changed
# 2: glint override added
# 3: tooltip_display added
# 4: glint override + tooltip_display added
# 5: enchantment tooltip hidden on an existing tooltip_display
# 6: glint override + enchantment tooltip hidden on an existing tooltip_display
scoreboard players set #diorama_weapon_state sgp.dummy 1

# Only suppress a newly-created enchantment glint. Never overwrite an explicit
# glint override that belongs to the original item.
execute if items entity @s weapon.mainhand *[!enchantments~[{}]] \
    unless data entity @s SelectedItem.components."minecraft:enchantment_glint_override" \
    run scoreboard players add #diorama_weapon_state sgp.dummy 1

# Check effective components: the default tooltip_display is absent from item NBT.
# Only a genuinely absent component needs removal on restoration.
execute if items entity @s weapon.mainhand *[!tooltip_display] \
    run scoreboard players add #diorama_weapon_state sgp.dummy 2
execute if items entity @s weapon.mainhand *[tooltip_display] \
    unless entity @s[nbt={SelectedItem:{components:{"minecraft:tooltip_display":{hidden_components:["minecraft:enchantments"]}}}}] \
    run scoreboard players add #diorama_weapon_state sgp.dummy 4

# Add the functional components first, then encode the restoration state in the
# custom enchantment level. The enchantment supports levels 1..6 solely so these
# internal restoration states are valid; its effect itself is level-independent.
item modify entity @s weapon.mainhand sgp.diorama:add_left_click_detect
execute if score #diorama_weapon_state sgp.dummy matches 2 run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"sgp.diorama:left_click_detection":2},add:false}
execute if score #diorama_weapon_state sgp.dummy matches 3 run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"sgp.diorama:left_click_detection":3},add:false}
execute if score #diorama_weapon_state sgp.dummy matches 4 run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"sgp.diorama:left_click_detection":4},add:false}
execute if score #diorama_weapon_state sgp.dummy matches 5 run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"sgp.diorama:left_click_detection":5},add:false}
execute if score #diorama_weapon_state sgp.dummy matches 6 run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"sgp.diorama:left_click_detection":6},add:false}

execute if score #diorama_weapon_state sgp.dummy matches 2 run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"minecraft:enchantment_glint_override":false}}
execute if score #diorama_weapon_state sgp.dummy matches 4 run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"minecraft:enchantment_glint_override":false}}
execute if score #diorama_weapon_state sgp.dummy matches 6 run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"minecraft:enchantment_glint_override":false}}

execute if score #diorama_weapon_state sgp.dummy matches 3..6 run item modify entity @s weapon.mainhand {function:"minecraft:toggle_tooltips",toggles:{"minecraft:enchantments":false}}
