#> sgp.kits:abilities/bats/hide/held_item
#
# `{slot: item_slot}`

$item replace entity @s weapon.mainhand from entity @p[tag=sgp.processing] $(slot)

# Mark special items (they already have an item_model) vs vanilla items (no item_model)
execute if data entity @s equipment.mainhand.components."minecraft:item_model" \
    run data modify entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special set value 1b
    
execute unless data entity @s equipment.mainhand.components."minecraft:item_model" \
    run data modify entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla set value 1b

# For special items, merge the "hidden" string into custom_model_data; For vanilla items, apply the empty item_model
execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special \
    if data entity @s equipment.mainhand.components."minecraft:custom_model_data" \
        run data modify entity @s equipment.mainhand.components."minecraft:custom_data".backup_cmd set from entity @s equipment.mainhand.components."minecraft:custom_model_data"
execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special \
    run data modify entity @s equipment.mainhand.components."minecraft:custom_model_data" merge value {strings:["hidden"]}

execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla \
    run data modify entity @s equipment.mainhand.components."minecraft:item_model" set value "sgp.kits:empty_model"


$item replace entity @p[tag=sgp.processing] $(slot) from entity @s weapon.mainhand