#> sgp.ci:loadouts/expect_enchantment
# `{slot: entity slot, item: item id, enchantment: enchantment id}`
#
# Assert a gameplay-significant enchantment on the item occupying an exact player slot.

$execute store success score @s sgp.dummy if items entity @s $(slot) $(item)[enchantments~[{enchantments:"$(enchantment)"}]]
assert score @s sgp.dummy matches 1
