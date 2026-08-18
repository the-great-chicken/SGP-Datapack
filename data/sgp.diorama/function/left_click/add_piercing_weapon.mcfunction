#> sgp.diorama:left_click/add_piercing_weapon
#
# Checks if the player lacks piercing weapon for left click detect,
# and provide it if so

execute unless items entity @s weapon.mainhand *[!piercing_weapon] run return 1
execute if items entity @s weapon.mainhand *[!enchantments~[{}]] run item modify entity @s weapon.mainhand {function:"minecraft:set_components",components:{"minecraft:enchantment_glint_override":0b}}
item modify entity @s weapon.mainhand sgp.diorama:add_left_click_detect