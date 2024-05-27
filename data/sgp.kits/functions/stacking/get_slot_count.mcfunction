#> sgp.kits:stacking/get_slot_count
# `{slot: 0-35 or 99}`
# 
# gets the number of items in the slot

scoreboard players set #slot_found sgp.dummy 1
$execute store result score #2e_nombre sgp.dummy run data get entity @s Inventory[{Slot:$(slot)b}].Count
$scoreboard players set #slot_number sgp.dummy $(slot)