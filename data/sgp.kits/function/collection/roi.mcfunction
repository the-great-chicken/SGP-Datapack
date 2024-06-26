#> sgp.kits:collection/roi
# 
# Gives the Roi kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with golden_sword{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:4.0d, Operation:0, UUID:[I; -124310, 13201, 13111, -26402]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Enchantments:[{id:"sharpness", lvl:7}], HideFlags:63, display:{Name:'{"text":"Épée Royale", "color":"yellow", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"⚔ Tranchant VII", "color":"dark_red", "italic":false}', '{"text":"8 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Enchantments:[{id:"power", lvl:2}], HideFlags:63, Unbreakable:1, display:{Name:'{"text":"Arc Royal", "color":"yellow", "italic":false, "bold":true}', Lore:['{"text":"-------------", "color":"#C0C0C0", "italic":false}', '{"text":"🏹 Puissance II", "color":"dark_red", "italic":false}']}}
item replace entity @s weapon.offhand with cooked_beef{display:{Name:'{"text":"Steak (cuit à la perfection)", "color":"yellow", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" et est absolument délicieux", "color":"gray", "italic":false}]']}} 32
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"yellow", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"gray", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 4
item replace entity @s hotbar.7 with arrow 12
item replace entity @s armor.head with golden_helmet{Trim:{pattern:ward, material:redstone}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Couronne", "color":"yellow", "italic":false, "bold":true}', Lore:['{"text":"------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.chest with golden_chestplate{Trim:{pattern:wild, material:diamond}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Cuirasse Cérémoniale", "color":"yellow", "italic":false, "bold":true}'}}
item replace entity @s armor.legs with golden_leggings{Trim:{pattern:eye, material:diamond}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Jambières Cérémoniales", "color":"yellow", "italic":false, "bold":true}'}}
item replace entity @s armor.feet with golden_boots{Trim:{pattern:dune, material:diamond}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Bottes Cérémoniales", "color":"yellow", "italic":false, "bold":true}'}}
tag @s add roi_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 6
execute as @a[tag=in_game] unless entity @s[tag=!roi_bleu, tag=!roi_rouge] run clear @a[scores={sgp.veut_roi=1..}]
execute as @a[tag=in_game] unless entity @s[tag=!roi_rouge, tag=!roi_bleu] run tellraw @a[scores={sgp.veut_roi=1..}] [{"text":"Le kit Roi n'est pas disponible pour cet event.","color":"dark_red"}]
scoreboard players set @s sgp.veut_roi 0
scoreboard players set @s sgp.kit_prefix_set 0