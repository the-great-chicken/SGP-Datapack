#> sgp.kits:abilities/bats/hide/armor_item
#
# `{slot: head|chest|legs|feet}`
# Back up the $slot armor item model, and replace it with an empty one


$item replace entity @s armor.$(slot) from entity @p[tag=sgp.processing] armor.$(slot)

$data modify entity @s equipment.$(slot).components."minecraft:custom_data".backup_eq set from entity @s equipment.$(slot).components."minecraft:equippable"
$data modify entity @s equipment.$(slot).components."minecraft:equippable" merge value {slot:"$(slot)"}
$data remove entity @s equipment.$(slot).components."minecraft:equippable".asset_id

$item replace entity @p[tag=sgp.processing] armor.$(slot) from entity @s armor.$(slot)