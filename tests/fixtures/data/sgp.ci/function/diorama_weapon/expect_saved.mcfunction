#> sgp.ci:diorama_weapon/expect_saved
# {key}
# Compare the complete inventory, including custom components.
data modify storage sgp.ci:diorama_weapon actual set from entity @s Inventory
$execute store success score @s sgp.dummy run data modify storage sgp.ci:diorama_weapon actual set from storage sgp.ci:diorama_weapon $(key)
assert score @s sgp.dummy matches 0
