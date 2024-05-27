#> sgp.kits:stacking/add_count_to_stack
# `{count, item_id, tag: item_nbt}`
# 
# Adds `<count>` `<item_id>` with `<item_nbt>` to the 1st slot containing some
# `<item_id>` in the inventory of the player

scoreboard players set #slot_found sgp.dummy 0
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:0b}] run function sgp.kits:stacking/get_slot_count {slot:0}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:1b}] run function sgp.kits:stacking/get_slot_count {slot:1}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:2b}] run function sgp.kits:stacking/get_slot_count {slot:2}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:3b}] run function sgp.kits:stacking/get_slot_count {slot:3}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:4b}] run function sgp.kits:stacking/get_slot_count {slot:4}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:5b}] run function sgp.kits:stacking/get_slot_count {slot:5}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:6b}] run function sgp.kits:stacking/get_slot_count {slot:6}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:7b}] run function sgp.kits:stacking/get_slot_count {slot:7}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:8b}] run function sgp.kits:stacking/get_slot_count {slot:8}

$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:9b}] run function sgp.kits:stacking/get_slot_count {slot:9}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:10b}] run function sgp.kits:stacking/get_slot_count {slot:10}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:11b}] run function sgp.kits:stacking/get_slot_count {slot:11}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:12b}] run function sgp.kits:stacking/get_slot_count {slot:12}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:13b}] run function sgp.kits:stacking/get_slot_count {slot:13}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:14b}] run function sgp.kits:stacking/get_slot_count {slot:14}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:15b}] run function sgp.kits:stacking/get_slot_count {slot:15}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:16b}] run function sgp.kits:stacking/get_slot_count {slot:16}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:17b}] run function sgp.kits:stacking/get_slot_count {slot:17}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:18b}] run function sgp.kits:stacking/get_slot_count {slot:18}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:19b}] run function sgp.kits:stacking/get_slot_count {slot:19}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:20b}] run function sgp.kits:stacking/get_slot_count {slot:20}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:21b}] run function sgp.kits:stacking/get_slot_count {slot:21}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:22b}] run function sgp.kits:stacking/get_slot_count {slot:22}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:23b}] run function sgp.kits:stacking/get_slot_count {slot:23}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:24b}] run function sgp.kits:stacking/get_slot_count {slot:24}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:25b}] run function sgp.kits:stacking/get_slot_count {slot:25}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:26b}] run function sgp.kits:stacking/get_slot_count {slot:26}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:27b}] run function sgp.kits:stacking/get_slot_count {slot:27}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:28b}] run function sgp.kits:stacking/get_slot_count {slot:28}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:29b}] run function sgp.kits:stacking/get_slot_count {slot:29}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:30b}] run function sgp.kits:stacking/get_slot_count {slot:30}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:31b}] run function sgp.kits:stacking/get_slot_count {slot:31}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:32b}] run function sgp.kits:stacking/get_slot_count {slot:32}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:33b}] run function sgp.kits:stacking/get_slot_count {slot:33}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:34b}] run function sgp.kits:stacking/get_slot_count {slot:34}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:35b}] run function sgp.kits:stacking/get_slot_count {slot:35}
$execute as @s unless score #slot_found sgp.dummy matches 1 if data entity @s Inventory[{id:"minecraft:$(item_id)", tag:{$(tag)}, Slot:99b}] run function sgp.kits:stacking/get_slot_count {slot:99}


$scoreboard players set #somme sgp.dummy $(count)
scoreboard players operation #somme sgp.dummy += #2e_nombre sgp.dummy

$execute at @s run summon armor_stand ~ ~20 ~ {CustomName:'"sgp.item_stacker"',Invulnerable:1b,NoGravity:1b,HandItems:[{id:"$(item_id)",tag:{$(tag)},Count:1}]}
execute store result entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] HandItems[0].Count int 1 run scoreboard players get #somme sgp.dummy

execute if score #slot_number sgp.dummy matches 0 run item replace entity @s hotbar.0 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 1 run item replace entity @s hotbar.1 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 2 run item replace entity @s hotbar.2 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 3 run item replace entity @s hotbar.3 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 4 run item replace entity @s hotbar.4 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 5 run item replace entity @s hotbar.5 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 6 run item replace entity @s hotbar.6 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 7 run item replace entity @s hotbar.7 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 8 run item replace entity @s hotbar.8 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 9 run item replace entity @s inventory.0 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 10 run item replace entity @s inventory.1 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 11 run item replace entity @s inventory.2 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 12 run item replace entity @s inventory.3 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 13 run item replace entity @s inventory.4 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 14 run item replace entity @s inventory.5 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 15 run item replace entity @s inventory.6 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 16 run item replace entity @s inventory.7 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 17 run item replace entity @s inventory.8 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 18 run item replace entity @s inventory.9 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 19 run item replace entity @s inventory.10 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 20 run item replace entity @s inventory.11 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 21 run item replace entity @s inventory.12 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 22 run item replace entity @s inventory.13 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 23 run item replace entity @s inventory.14 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 24 run item replace entity @s inventory.15 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 25 run item replace entity @s inventory.16 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 26 run item replace entity @s inventory.17 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 27 run item replace entity @s inventory.18 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 28 run item replace entity @s inventory.19 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 29 run item replace entity @s inventory.20 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 30 run item replace entity @s inventory.21 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 31 run item replace entity @s inventory.22 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 32 run item replace entity @s inventory.23 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 33 run item replace entity @s inventory.24 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 34 run item replace entity @s inventory.25 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 35 run item replace entity @s inventory.26 from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
execute if score #slot_number sgp.dummy matches 99 run item replace entity @s weapon.offhand from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand

kill @e[type=armor_stand,name="sgp.item_stacker",limit=1]