# Setup the armor stand properties so it is safe and invisible
data merge entity @s {Invisible:1b, Marker:1b, drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f,mainhand:0.0f,offhand:0.0f,body:0.0f,saddle:0.0f}}

# --- TRANSFER ALL EQUIPMENT FROM PLAYER TO ARMOR STAND ---
item replace entity @s armor.head from entity @a[tag=sgp.processing,limit=1] armor.head
item replace entity @s armor.chest from entity @a[tag=sgp.processing,limit=1] armor.chest
item replace entity @s armor.legs from entity @a[tag=sgp.processing,limit=1] armor.legs
item replace entity @s armor.feet from entity @a[tag=sgp.processing,limit=1] armor.feet
item replace entity @s weapon.mainhand from entity @a[tag=sgp.processing,limit=1] weapon.mainhand
item replace entity @s weapon.offhand from entity @a[tag=sgp.processing,limit=1] weapon.offhand


# --- RESTORE ARMOR (Chest, Legs, Feet) ---
# Chest
data remove entity @s equipment.chest.components."minecraft:equippable"
data modify entity @s equipment.chest.components."minecraft:equippable" set from entity @s equipment.chest.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.chest.components."minecraft:custom_data".backup_eq
item replace entity @a[tag=sgp.processing,limit=1] armor.chest from entity @s armor.chest

# Legs
data remove entity @s equipment.legs.components."minecraft:equippable"
data modify entity @s equipment.legs.components."minecraft:equippable" set from entity @s equipment.legs.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.legs.components."minecraft:custom_data".backup_eq
item replace entity @a[tag=sgp.processing,limit=1] armor.legs from entity @s armor.legs

# Feet
data remove entity @s equipment.feet.components."minecraft:equippable"
data modify entity @s equipment.feet.components."minecraft:equippable" set from entity @s equipment.feet.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.feet.components."minecraft:custom_data".backup_eq
item replace entity @a[tag=sgp.processing,limit=1] armor.feet from entity @s armor.feet


# --- RESTORE HELMET (Head) ---
# Restore Armor model
data remove entity @s equipment.head.components."minecraft:equippable"
data modify entity @s equipment.head.components."minecraft:equippable" set from entity @s equipment.head.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.head.components."minecraft:custom_data".backup_eq

# Restore 3D block/item model
data remove entity @s equipment.head.components."minecraft:item_model"
data modify entity @s equipment.head.components."minecraft:item_model" set from entity @s equipment.head.components."minecraft:custom_data".backup_model
data remove entity @s equipment.head.components."minecraft:custom_data".backup_model

item replace entity @a[tag=sgp.processing,limit=1] armor.head from entity @s armor.head


# --- RESTORE HELD ITEMS (Mainhand, Offhand) ---
# Mainhand
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.0"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.1"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.2"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.3"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.4"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.5"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.6"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.7"}
function sgp.kits:abilities/bats/restore_hotbar_slot {slot: "hotbar.8"}

# Offhand
data remove entity @s equipment.offhand.components."minecraft:item_model"
data modify entity @s equipment.offhand.components."minecraft:item_model" set from entity @s equipment.offhand.components."minecraft:custom_data".backup_model
data remove entity @s equipment.offhand.components."minecraft:custom_data".backup_model
item replace entity @a[tag=sgp.processing,limit=1] weapon.offhand from entity @s weapon.offhand


# --- CLEANUP ---
kill @s