#> sgp.kits:collection/archer
# 
# Gives the Archer kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with wooden_sword{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:4.0d, Operation:0, UUID:[I; -124310, 13201, 13111, -26402]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], HideFlags:7, display:{Name:'{"text":"Épée d\'Entraînement", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"--------------------", "color":"#C0C0C0", "italic":false}', '{"text":"4 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Enchantments:[{id:"power", lvl:3}, {id:"infinity", lvl:1}, {id:"punch", lvl:1}], Unbreakable:1, HideFlags:7, display:{Name:'{"text":"Arc d\'Élite", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"-------------", "color":"#C0C0C0", "italic":false}', '{"text":"🏹 Puissance III", "color":"dark_red", "italic":false}', '{"text":"⬱ Recul I", "color":"#6F4E37", "italic":false}', '{"text":"∞ Infinité", "color":"#E5E4E2", "italic":false}']}}
item replace entity @s hotbar.3 with cooked_beef{display:{Name:'{"text":"Steak", "color":"green", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"green", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"gray", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 3
item replace entity @s hotbar.4 with arrow
item replace entity @s hotbar.5 with tipped_arrow{Potion:"water", custom_potion_effects:[{id:"slowness", amplifier:1, duration:1760}], HideFlags:63, display:{Name:'{"text":"Flèche de Lenteur", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⬳ Lenteur II (1:28)", "color":"#555555", "italic":false}']}} 2
item replace entity @s weapon.offhand with tipped_arrow{Potion:"long_poison", HideFlags:63, display:{Name:'{"text":"Flèche de Poison", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"-----------------", "color":"#C0C0C0", "italic":false}', '{"text":"☠ Poison (0:11)", "color":"#55741B", "italic":false}']}} 5
item replace entity @s armor.head with leather_helmet{Trim:{pattern:coast, material:quartz}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{color:9633536, Name:'{"text":"Chapeau en Cuir", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.chest with chainmail_chestplate{Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Cotte de Mailles", "color":"green", "italic":false, "bold":true}'}}
item replace entity @s armor.legs with leather_leggings{Trim:{pattern:spire, material:quartz}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{color:9633536, Name:'{"text":"Pantalon en Cuir", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.feet with leather_boots{Trim:{pattern:spire, material:quartz}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{color:9633536, Name:'{"text":"Bottes en Cuir", "color":"green", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}
effect give @s speed infinite 0
tag @s add sgp.archer_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.veut_archer 0
scoreboard players set @s sgp.kit_prefix_set 0