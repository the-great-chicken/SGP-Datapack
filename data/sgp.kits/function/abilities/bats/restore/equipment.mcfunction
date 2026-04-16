#> sgp.kits:abilities/bats/restore/equipment

# Setup the armor stand properties so it is safe and invisible
data merge entity @s {Invisible:1b, Marker:1b, drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f,mainhand:0.0f,offhand:0.0f}}

# --- RESTORE ARMOR (Chest, Legs, Feet) ---
function sgp.kits:abilities/bats/restore/armor_item {slot:chest}
function sgp.kits:abilities/bats/restore/armor_item {slot:legs}
function sgp.kits:abilities/bats/restore/armor_item {slot:feet}


# --- RESTORE HELMET (Head) ---
item replace entity @s armor.head from entity @p[tag=sgp.processing] armor.head

# Restore Armor model
data remove entity @s equipment.head.components."minecraft:equippable"
data modify entity @s equipment.head.components."minecraft:equippable" set from entity @s equipment.head.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.head.components."minecraft:custom_data".backup_eq

# Restore 3D block/item model
data remove entity @s equipment.head.components."minecraft:item_model"
data modify entity @s equipment.head.components."minecraft:item_model" set from entity @s equipment.head.components."minecraft:custom_data".backup_model
data remove entity @s equipment.head.components."minecraft:custom_data".backup_model

item replace entity @p[tag=sgp.processing] armor.head from entity @s armor.head


# --- RESTORE HELD ITEMS (Mainhand, Offhand) ---
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.0"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.1"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.2"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.3"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.4"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.5"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.6"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.7"}
function sgp.kits:abilities/bats/restore/held_item {slot: "hotbar.8"}

function sgp.kits:abilities/bats/restore/held_item {slot: "weapon.offhand"}


kill @s