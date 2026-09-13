#> sgp.kits:abilities/bats/restore/helmet
# Restore only a helmet hidden by this ability; replacement equipment keeps its appearance.

item replace entity @s armor.head from entity @p[tag=sgp.processing] armor.head
execute unless data entity @s equipment.head.components."minecraft:custom_data".hidden_armor run return 0

data remove entity @s equipment.head.components."minecraft:equippable"
data modify entity @s equipment.head.components."minecraft:equippable" set from entity @s equipment.head.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.head.components."minecraft:custom_data".backup_eq
data remove entity @s equipment.head.components."minecraft:item_model"
data modify entity @s equipment.head.components."minecraft:item_model" set from entity @s equipment.head.components."minecraft:custom_data".backup_model
data remove entity @s equipment.head.components."minecraft:custom_data".backup_model
data remove entity @s equipment.head.components."minecraft:custom_data".hidden_armor
execute store result score #is_data_present sgp.dummy run data get entity @s equipment.head.components."minecraft:custom_data"
execute if score #is_data_present sgp.dummy matches 0 run data remove entity @s equipment.head.components."minecraft:custom_data"

item replace entity @p[tag=sgp.processing] armor.head from entity @s armor.head
