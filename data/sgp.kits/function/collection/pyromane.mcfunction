#> sgp.kits:collection/pyromane
# 
# Gives the Pyromane kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with blaze_rod{AttributeModifiers:[{Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Unbreakable:1, Enchantments:[{id:"sharpness", lvl:9}, {id:"knockback", lvl:1}, {id:"fire_aspect", lvl:1}], HideFlags:63, display:{Name:'{"text":"Bâton Brûlant", "color":"gold", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"⚔ Tranchant IX", "color":"dark_red", "italic":false}', '{"text":"🔥 Flamme I", "color":"#FF8C00", "italic":false}', '{"text":"⬱ Recul I", "color":"#6F4E37", "italic":false}', '{"text":"6 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Enchantments:[{id:"flame", lvl:1}], Unbreakable:1, HideFlags:63, display:{Name:'{"text":"Arc Brûlant", "color":"gold", "italic":false, "bold":true}', Lore:['{"text":"------------", "color":"#C0C0C0", "italic":false}', '{"text":"🔥 Flamme", "color":"#FF8C00", "italic":false}']}}
item replace entity @s hotbar.3 with cooked_beef{display:{Name:'{"text":"Steak", "color":"gold", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"gold", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"gray", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 2
item replace entity @s weapon.offhand with flint_and_steel{Unbreakable:1, HideFlags:63, display:{Name:'{"text":"Briquet", "color":"gold", "italic":false, "bold":true}'}}
item replace entity @s hotbar.4 with firework_rocket{Fireworks:{Explosions:[{Type:1, Flicker:1, Colors:[I; 11743532, 15435844], FadeColors:[I; 14602026, 15435844]}, {Type:1, Flicker:1, Colors:[I; 11743532, 15435844], FadeColors:[I; 14602026, 15435844]}], Flight:-2}, HideFlags:63, display:{Name:'{"text":"Explosifs", "color":"red", "italic":false, "bold":true}'}} 5
item replace entity @s hotbar.7 with arrow 8
item replace entity @s armor.head with iron_helmet{Trim:{pattern:wild, material:gold}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Casque en Fer", "color":"gold", "italic":false, "bold":true}'}}
item replace entity @s armor.chest with iron_chestplate{Trim:{pattern:snout, material:gold}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Plastron en Fer", "color":"gold", "italic":false, "bold":true}'}}
item replace entity @s armor.legs with diamond_leggings{Trim:{pattern:silence, material:gold}, Unbreakable:1, Enchantments:[{id:"protection", lvl:2}, {id:"thorns", lvl:2}, {id:"fire_protection", lvl:6}, {id:"blast_protection", lvl:5}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Jambières Ignifuges", "color":"gold", "italic":false, "bold":true}', Lore:['{"text":"--------------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}', '{"text":"🔥 Protection VI", "color":"gold", "italic":false}', '{"text":"☀ Protection V", "color":"red", "italic":false}', '{"text":"᠅ Épines II", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.feet with iron_boots{Trim:{pattern:wayfinder, material:gold}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Bottes en Fer", "color":"gold", "italic":false, "bold":true}'}}
tag @s add pyromane_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 4
scoreboard players set @s sgp.veut_pyromane 0
scoreboard players set @s sgp.kit_prefix_set 0