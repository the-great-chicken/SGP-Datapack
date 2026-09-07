#> sgp.kits:bats/equipment/replacement_armor
# @dummy
# @environment sgp.ci:bats_equipment
#
# Armor equipped after hiding keeps its own appearance and components; removed armor must not return.

function sgp.ci:bats_equipment/fixture
function sgp.ci:bats_equipment/hide
item replace entity @s armor.head with golden_helmet[item_model="minecraft:diamond",equippable={slot:head,asset_id:"minecraft:iron"},custom_data={ci_new:1}]
item replace entity @s armor.chest with golden_chestplate[equippable={slot:chest,asset_id:"minecraft:iron"},custom_data={ci_new:2}]
item replace entity @s armor.feet with air
data modify storage sgp.ci:bats_equipment replacement_before set value {}
data modify storage sgp.ci:bats_equipment replacement_before.head set from entity @s equipment.head
data modify storage sgp.ci:bats_equipment replacement_before.chest set from entity @s equipment.chest
function sgp.kits:abilities/bats/end
data modify storage sgp.ci:bats_equipment replacement_after set value {}
data modify storage sgp.ci:bats_equipment replacement_after.head set from entity @s equipment.head
data modify storage sgp.ci:bats_equipment replacement_after.chest set from entity @s equipment.chest
execute store success score @s sgp.dummy run data modify storage sgp.ci:bats_equipment replacement_after set from storage sgp.ci:bats_equipment replacement_before
assert score @s sgp.dummy matches 0
assert not data entity @s equipment.feet
