#> sgp.ci:bats_equipment/snapshot
# Capture inventory and equipment together, including empty equipment.

$data modify storage sgp.ci:bats_equipment $(key) set value {}
$data modify storage sgp.ci:bats_equipment $(key).inventory set from entity @s Inventory
$data modify storage sgp.ci:bats_equipment $(key).equipment set from entity @s equipment
