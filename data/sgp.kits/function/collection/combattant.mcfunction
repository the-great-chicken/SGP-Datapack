#> sgp.kits:collection/combattant
# 
# Gives the Combattant kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with iron_sword{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:6.0d, Operation:0, UUID:[I; -124310, 12201, 13111, -24402]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Enchantments:[{id:"sharpness", lvl:1}], HideFlags:7, display:{Name:'{"text":"Épée en Fer", "color":"white", "italic":false, "bold":true}', Lore:['{"text":"------------", "color":"#C0C0C0", "italic":false}', '{"text":"⚔ Tranchant I", "color":"dark_red", "italic":false}', '{"text":"7 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Unbreakable:1, HideFlags:4, display:{Name:'{"text":"Arc", "color":"white", "italic":false, "bold":true}'}}
item replace entity @s weapon.offhand with cooked_beef{display:{Name:'{"text":"Steak", "color":"white", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"white", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"gray", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 2
item replace entity @s hotbar.7 with arrow 16
item replace entity @s armor.head with iron_helmet{Trim:{pattern:spire, material:copper}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Casque en Fer", "color":"white", "italic":false, "bold":true}'}}
item replace entity @s armor.chest with iron_chestplate{Trim:{pattern:coast, material:copper}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Plastron en Fer", "color":"white", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.legs with iron_leggings{Trim:{pattern:spire, material:copper}, Unbreakable:1, Enchantments:[{id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Jambières en Fer", "color":"white", "italic":false, "bold":true}', Lore:['{"text":"-----------------", "color":"#C0C0C0", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.feet with iron_boots{Trim:{pattern:eye, material:copper}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Bottes en Fer", "color":"white", "italic":false, "bold":true}'}}
tag @s add combattant_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 1
scoreboard players set @s sgp.veut_combattant 0
scoreboard players set @s sgp.kit_prefix_set 0