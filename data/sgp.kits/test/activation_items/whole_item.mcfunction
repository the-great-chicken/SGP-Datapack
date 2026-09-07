#> sgp.kits:activation_items/whole_item
# @dummy
# @environment sgp.ci:activation_items
#
# Returning a complete dropped item preserves its durability, enchantments, name, and custom data.

function sgp.ci:activation_items/fixture
item replace entity @s hotbar.0 with diamond_sword[damage=17,enchantments={sharpness:3,unbreaking:2},custom_name={text:"CI blade"},custom_data={ci_keep:9}]
data modify storage sgp.ci:activation_items blade_before set from entity @s Inventory
dummy @s drop all
function sgp.ci:activation_items/track_drops
assert not entity @s[nbt={Inventory:[{}]}]
function sgp.kits:abilities/main_trigger
function sgp.ci:activation_items/expect_inventory {key:blade_before}
assert not entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert not data block ~6 ~1 ~ Items[0]
