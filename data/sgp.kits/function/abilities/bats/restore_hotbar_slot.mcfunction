#> sgp.kits:abilities/bats/restore_hotbar_slot

# 1. Pull the item from the player's specific slot into the armor stand's mainhand
$item replace entity @s weapon.mainhand from entity @a[tag=sgp.processing,limit=1] $(slot)

# 2. Check if the item has been hidden at all. If so, execute the restore logic.
execute unless data entity @s equipment.mainhand.components."minecraft:item_model" run return 1

# --- 1. RESTORE ITEMS ---
# Restore special items by removing the custom_model_data component
execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special run data remove entity @s equipment.mainhand.components."minecraft:custom_model_data"

# Restore vanilla items by removing the item_model component entirely
execute if data entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla run data remove entity @s equipment.mainhand.components."minecraft:item_model"

# --- 2. CLEANUP ---
# Remove our temporary tracking flags so the item is clean
data remove entity @s equipment.mainhand.components."minecraft:custom_data".hidden_special
data remove entity @s equipment.mainhand.components."minecraft:custom_data".hidden_vanilla

# 3. Put the processed item back into the exact same player slot
$item replace entity @a[tag=sgp.processing,limit=1] $(slot) from entity @s weapon.mainhand