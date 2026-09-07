#> sgp.ci:activation_items/expect_inventory
# A returned item must preserve all saved item components and counts.

assert entity @s[nbt={Inventory:[{}]}]
data modify storage sgp.ci:activation_items actual set from entity @s Inventory
$execute store success score @s sgp.dummy run data modify storage sgp.ci:activation_items actual set from storage sgp.ci:activation_items $(key)
assert score @s sgp.dummy matches 0
