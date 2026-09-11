#> sgp.ci:loadouts/expect_slot
# `{slot: entity slot, item: item id}`
#
# Assert that the current player's exact equipment/inventory slot contains the expected item type.

$execute store success score @s sgp.dummy if items entity @s $(slot) $(item)
assert score @s sgp.dummy matches 1
