#> sgp.kits:collection/eclaireur
# 
# Gives the Eclaireur kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with stone_sword{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:5.0d, Operation:0, UUID:[I; -124310, 13101, 13111, -26202]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], HideFlags:63, display:{Name:'{"text":"Épée en Pierre", "color":"aqua", "italic":false, "bold":true}', Lore:['{"text":"---------------", "color":"gray", "italic":false}', '{"text":"5 dégats", "color":"blue", "italic":false}']}}
item replace entity @s weapon.offhand with cooked_beef{display:{Name:'{"text":"Steak", "color":"aqua", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
item replace entity @s hotbar.1 with crossbow{Unbreakable:1, HideFlags:7, display:{Name:'{"text":"Arbalète", "color":"aqua", "italic":false, "bold":true}'}}
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"aqua", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"#C0C0C0", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 6
item replace entity @s hotbar.7 with arrow 3
effect give @s speed infinite 2
effect give @s jump_boost infinite 1
item replace entity @s armor.head with leather_helmet{Trim:{pattern:raiser, material:emerald}, Unbreakable:1, Enchantments:[{id:"thorns", lvl:3}], HideFlags:255, display:{Name:'{"text":"Chapeau en Cuir", "color":"aqua", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.chest with leather_chestplate{Trim:{pattern:raiser, material:emerald}, Unbreakable:1, Enchantments:[{id:"thorns", lvl:3}], HideFlags:255, display:{Name:'{"text":"Tunique en Cuir", "color":"aqua", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.legs with leather_leggings{Trim:{pattern:raiser, material:emerald}, Unbreakable:1, Enchantments:[{id:"thorns", lvl:3}], HideFlags:255, display:{Name:'{"text":"Pantalon en Cuir", "color":"aqua", "italic":false, "bold":true}', Lore:['{"text":"-----------------", "color":"#C0C0C0", "italic":false}', '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.feet with diamond_boots{Trim:{pattern:spire, material:diamond}, Unbreakable:1, Enchantments:[{id:"protection", lvl:3}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Bottes d\'Exploration", "color":"aqua", "italic":false, "bold":true}', Lore:['{"text":"--------------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}']}}
tag @s add sgp.eclaireur_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 7
scoreboard players set @s sgp.veut_eclaireur 0
scoreboard players set @s sgp.kit_prefix_set 0