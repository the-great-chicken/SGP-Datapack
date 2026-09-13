#> sgp.diorama:left_click/restore_weapon
#
# Restore only components that Diorama itself introduced. The temporary
# left_click_detection level records the original presentation state.

# Remove a glint override only when Diorama created it.
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:2}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"!minecraft:enchantment_glint_override":{}}}
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:4}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"!minecraft:enchantment_glint_override":{}}}
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:6}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"!minecraft:enchantment_glint_override":{}}}

# If Diorama created tooltip_display from nothing, remove that component again.
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:3}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"!minecraft:tooltip_display":{}}}
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:4}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"!minecraft:tooltip_display":{}}}

# Otherwise Diorama hid only the enchantments entry of an existing tooltip_display;
# toggle that entry back on while preserving all other tooltip settings.
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:5}]] run item modify entity @s weapon.mainhand {function:"minecraft:toggle_tooltips",toggles:{"minecraft:enchantments":true}}
execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"sgp.diorama:left_click_detection",levels:6}]] run item modify entity @s weapon.mainhand {function:"minecraft:toggle_tooltips",toggles:{"minecraft:enchantments":true}}

# Finally remove the two functional components Diorama always added.
item modify entity @s weapon.mainhand sgp.diorama:remove_left_click_detect
