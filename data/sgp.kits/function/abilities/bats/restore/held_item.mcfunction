#> sgp.kits:abilities/bats/restore/held_item
#
# `{slot: player item_slot}`

$item replace entity @s weapon.mainhand from entity @p[tag=sgp.processing] $(slot)

# Check if the item has been hidden at all. If so, execute the restore logic.
execute unless data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special unless data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla run return 1

execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special \
    run data remove entity @s equipment.mainhand.components."minecraft:custom_model_data"

execute if data entity @s equipment.mainhand.components."minecraft:custom_data".backup_cmd \
    run data modify entity @s equipment.mainhand.components."minecraft:custom_model_data" set from entity @s equipment.mainhand.components."minecraft:custom_data".backup_cmd
data remove entity @s equipment.mainhand.components."minecraft:custom_data".backup_cmd

execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla \
    run data remove entity @s equipment.mainhand.components."minecraft:item_model"


data remove entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special
data remove entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla

$item replace entity @p[tag=sgp.processing] $(slot) from entity @s weapon.mainhand