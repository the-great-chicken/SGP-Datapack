#> sgp.kits:abilities/bats/restore/armor_item
#
# `{slot: head|chest|legs|feet}`

$item replace entity @s armor.$(slot) from entity @p[tag=sgp.processing] armor.$(slot)

$data remove entity @s equipment.$(slot).components."minecraft:equippable"
$data modify entity @s equipment.$(slot).components."minecraft:equippable" set from entity @s equipment.$(slot).components."minecraft:custom_data".backup_eq
$data remove entity @s equipment.$(slot).components."minecraft:custom_data".backup_eq

$item replace entity @p[tag=sgp.processing] armor.$(slot) from entity @s armor.$(slot)