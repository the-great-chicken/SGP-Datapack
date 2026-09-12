#> sgp.kits:bats/equipment/moved_item
# @dummy
# @environment sgp.ci:bats_equipment
#
# Moving a hidden item to another hotbar slot preserves its new position and restores its original properties.

function sgp.ci:bats_equipment/fixture
data modify storage sgp.ci:bats_equipment moved_before set from entity @s Inventory[{Slot:0b}]
data remove storage sgp.ci:bats_equipment moved_before.Slot
function sgp.ci:bats_equipment/hide
item replace entity @s hotbar.8 from entity @s hotbar.0
item replace entity @s hotbar.0 with air
function sgp.kits:abilities/bats/end
assert not entity @s[nbt={Inventory:[{Slot:0b}]}]
assert entity @s[nbt={Inventory:[{Slot:8b,id:"minecraft:diamond_sword"}]}]
data modify storage sgp.ci:bats_equipment moved_after set from entity @s Inventory[{Slot:8b}]
data remove storage sgp.ci:bats_equipment moved_after.Slot
execute store success score @s sgp.dummy run data modify storage sgp.ci:bats_equipment moved_after set from storage sgp.ci:bats_equipment moved_before
assert score @s sgp.dummy matches 0
execute store result score @s sgp.dummy run clear @s diamond_sword 0
assert score @s sgp.dummy matches 1
