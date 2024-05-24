scoreboard players set #slot_found dummy 1
$execute store result score #2e_nombre dummy run data get entity @s Inventory[{Slot:$(slot)}].Count
$scoreboard players set #slot_number dummy $(slot)