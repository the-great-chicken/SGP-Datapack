#> sgp.kits:abilities/bats/restore/armor_item
# `{slot: head|chest|legs|feet}`

$item replace entity @s armor.$(slot) from entity @p[tag=sgp.processing] armor.$(slot)
$execute unless data entity @s equipment.$(slot).components."minecraft:custom_data".hidden_armor run return 0

$data remove entity @s equipment.$(slot).components."minecraft:equippable"
$data modify entity @s equipment.$(slot).components."minecraft:equippable" set from entity @s equipment.$(slot).components."minecraft:custom_data".backup_eq
$data remove entity @s equipment.$(slot).components."minecraft:custom_data".backup_eq
$data remove entity @s equipment.$(slot).components."minecraft:custom_data".hidden_armor
$execute store result score #is_data_present sgp.dummy run data get entity @s equipment.$(slot).components."minecraft:custom_data"
$execute if score #is_data_present sgp.dummy matches 0 run data remove entity @s equipment.$(slot).components."minecraft:custom_data"

$item replace entity @p[tag=sgp.processing] armor.$(slot) from entity @s armor.$(slot)
