#> sgp.mineurs:lootdrop/show_item/name_precedence
# @dummy
#
# An anvil name takes precedence over the supplied item name, which takes precedence over the vanilla name.

tag @s add sgp.in_game
item replace entity @s weapon.mainhand with minecraft:diamond[minecraft:item_name="Supplied name",minecraft:custom_name="Anvil name"]
function sgp.mineurs:lootdrop/show_item/main
assert chat ".*Anvil name.*" @s
item replace entity @s weapon.mainhand with minecraft:diamond[minecraft:item_name="Supplied name"]
function sgp.mineurs:lootdrop/show_item/main
assert chat ".*Supplied name.*" @s
item replace entity @s weapon.mainhand with minecraft:diamond
function sgp.mineurs:lootdrop/show_item/main
assert data storage sgp:macro item_name[{translate:"item.minecraft.diamond"}]
assert data storage sgp:macro item_name[{translate:"block.minecraft.diamond"}]
