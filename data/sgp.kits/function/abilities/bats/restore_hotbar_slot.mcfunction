#> sgp.kits:abilities/bats/restore_hotbar_slot

# 1. Pull the item from the player's specific slot into the armor stand's mainhand
$item replace entity @s weapon.mainhand from entity @a[tag=sgp.processing,limit=1] $(slot)

# 2. Check if the item has the backup data. If so, execute the restore logic.
execute unless data entity @s equipment.mainhand.components."minecraft:item_model" run return 1
data remove entity @s equipment.mainhand.components."minecraft:item_model"
execute if data entity @s equipment.mainhand.components."minecraft:custom_data".backup_model \
    run data modify entity @s equipment.mainhand.components."minecraft:item_model" set from entity @s equipment.mainhand.components."minecraft:custom_data".backup_model
data remove entity @s equipment.mainhand.components."minecraft:custom_data".backup_model

# 3. Put the processed item back into the exact same player slot
$item replace entity @a[tag=sgp.processing,limit=1] $(slot) from entity @s weapon.mainhand