# Setup the armor stand properties so it is safe and invisible
data merge entity @s {Invisible:1b, Marker:1b, drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f,mainhand:0.0f,offhand:0.0f,body:0.0f,saddle:0.0f}}

# --- TRANSFER ALL EQUIPMENT FROM PLAYER TO ARMOR STAND ---
item replace entity @s armor.head from entity @a[tag=sgp.processing,limit=1] armor.head
item replace entity @s armor.chest from entity @a[tag=sgp.processing,limit=1] armor.chest
item replace entity @s armor.legs from entity @a[tag=sgp.processing,limit=1] armor.legs
item replace entity @s armor.feet from entity @a[tag=sgp.processing,limit=1] armor.feet
item replace entity @s weapon.mainhand from entity @a[tag=sgp.processing,limit=1] weapon.mainhand
item replace entity @s weapon.offhand from entity @a[tag=sgp.processing,limit=1] weapon.offhand

# --- HIDE ARMOR (Chest, Legs, Feet) ---
# Chest
data modify entity @s equipment.chest.components."minecraft:custom_data".backup_eq set from entity @s equipment.chest.components."minecraft:equippable"
data modify entity @s equipment.chest.components."minecraft:equippable" merge value {slot:"chest"}
data remove entity @s equipment.chest.components."minecraft:equippable".asset_id

# Legs
data modify entity @s equipment.legs.components."minecraft:custom_data".backup_eq set from entity @s equipment.legs.components."minecraft:equippable"
data modify entity @s equipment.legs.components."minecraft:equippable" merge value {slot:"legs"}
data remove entity @s equipment.legs.components."minecraft:equippable".asset_id

# Feet
data modify entity @s equipment.feet.components."minecraft:custom_data".backup_eq set from entity @s equipment.feet.components."minecraft:equippable"
data modify entity @s equipment.feet.components."minecraft:equippable" merge value {slot:"feet"}
data remove entity @s equipment.feet.components."minecraft:equippable".asset_id


# --- HIDE HELMET (Head) ---
# The helmet requires both the equippable stripping (for armor) and the item_model replacement (for blocks/items)
data modify entity @s equipment.head.components."minecraft:custom_data".backup_eq set from entity @s equipment.head.components."minecraft:equippable"
data modify entity @s equipment.head.components."minecraft:equippable" merge value {slot:"head"}
data remove entity @s equipment.head.components."minecraft:equippable".asset_id

data modify entity @s equipment.head.components."minecraft:custom_data".backup_model set from entity @s equipment.head.components."minecraft:item_model"
data modify entity @s equipment.head.components."minecraft:item_model" set value "sgp.kits:empty_model"


# --- HIDE HELD ITEMS (Mainhand, Offhand) ---
# Mainhand
data modify entity @s equipment.mainhand.components."minecraft:custom_data".backup_model set from entity @s equipment.mainhand.components."minecraft:item_model"
data modify entity @s equipment.mainhand.components."minecraft:item_model" set value "sgp.kits:empty_model"

# Offhand
data modify entity @s equipment.offhand.components."minecraft:custom_data".backup_model set from entity @s equipment.offhand.components."minecraft:item_model"
data modify entity @s equipment.offhand.components."minecraft:item_model" set value "sgp.kits:empty_model"


# --- RETURN ITEMS TO PLAYER ---
item replace entity @a[tag=sgp.processing,limit=1] armor.head from entity @s armor.head
item replace entity @a[tag=sgp.processing,limit=1] armor.chest from entity @s armor.chest
item replace entity @a[tag=sgp.processing,limit=1] armor.legs from entity @s armor.legs
item replace entity @a[tag=sgp.processing,limit=1] armor.feet from entity @s armor.feet
item replace entity @a[tag=sgp.processing,limit=1] weapon.mainhand from entity @s weapon.mainhand
item replace entity @a[tag=sgp.processing,limit=1] weapon.offhand from entity @s weapon.offhand

# --- CLEANUP ---
kill @s