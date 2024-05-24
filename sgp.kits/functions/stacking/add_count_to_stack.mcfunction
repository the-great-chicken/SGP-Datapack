# Paramètres : 
# $(nombre) = nombre à ajouter
# $(item_id) = id de l'item à ajouter
# $(tag) = infos de l'item à ajouter

execute as @s run function sgp.kits:kills_give/a

$scoreboard players set #somme dummy $(nombre)
scoreboard players operation #somme dummy += #2e_nombre dummy

$execute at @s run summon armor_stand ~ ~ ~ {CustomName:'[{"text":"item_stacker"}]',Invulnerable:1b,NoGravity:1b,HandItems:[{id:"$(item_id)",tag:{$(tag)},Count:1}]}
execute store result entity @e[type=armor_stand,name="alchimiste_potion_stacker",limit=1] HandItems[0].Count int 1 run scoreboard players get #somme dummy

execute if score #slot_number dummy matches 0 run item replace entity @s hotbar.0 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 1 run item replace entity @s hotbar.1 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 2 run item replace entity @s hotbar.2 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 3 run item replace entity @s hotbar.3 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 4 run item replace entity @s hotbar.4 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 5 run item replace entity @s hotbar.5 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 6 run item replace entity @s hotbar.6 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 7 run item replace entity @s hotbar.7 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 8 run item replace entity @s hotbar.8 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 9 run item replace entity @s inventory.0 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 10 run item replace entity @s inventory.1 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 11 run item replace entity @s inventory.2 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 12 run item replace entity @s inventory.3 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 13 run item replace entity @s inventory.4 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 14 run item replace entity @s inventory.5 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 15 run item replace entity @s inventory.6 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 16 run item replace entity @s inventory.7 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 17 run item replace entity @s inventory.8 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 18 run item replace entity @s inventory.9 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 19 run item replace entity @s inventory.10 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 20 run item replace entity @s inventory.11 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 21 run item replace entity @s inventory.12 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 22 run item replace entity @s inventory.13 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 23 run item replace entity @s inventory.14 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 24 run item replace entity @s inventory.15 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 25 run item replace entity @s inventory.16 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 26 run item replace entity @s inventory.17 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 27 run item replace entity @s inventory.18 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 28 run item replace entity @s inventory.19 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 29 run item replace entity @s inventory.20 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 30 run item replace entity @s inventory.21 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 31 run item replace entity @s inventory.22 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 32 run item replace entity @s inventory.23 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 33 run item replace entity @s inventory.24 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 34 run item replace entity @s inventory.25 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand
execute if score #slot_number dummy matches 35 run item replace entity @s inventory.26 from entity @e[type=armor_stand,name="item_stacker",limit=1] weapon.mainhand

kill @e[type=armor_stand,name="alchimiste_potion_stacker",limit=1]
