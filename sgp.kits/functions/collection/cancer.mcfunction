clear @s
effect clear @s
item replace entity @s hotbar.0 with stick{AttributeModifiers:[{Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Unbreakable:1, Enchantments:[{id:"knockback", lvl:4}, {id:"sharpness", lvl:12}], HideFlags:127, display:{Name:'{"text":"Bâton Cancérigène", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"-------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⚔ Tranchant XII", "color":"dark_red", "italic":false}', '{"text":"⬱ Recul IV", "color":"#6F4E37", "italic":false}', '{"text":"7,5 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Enchantments:[{id:"punch", lvl:4}, {id:"flame", lvl:1}], Unbreakable:1, HideFlags:63, display:{Name:'{"text":"Arc Cancérigène", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"-----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🔥 Flamme", "color":"#FF8C00", "italic":false}', '{"text":"⬱ Recul IV", "color":"#6F4E37", "italic":false}']}}
item replace entity @s weapon.offhand with cooked_beef{display:{Name:'{"text":"Steak", "color":"dark_red", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
item replace entity @s hotbar.2 with golden_apple{display:{Name:'{"text":"Pomme d\'or", "color":"dark_red", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}, {"text":" + 2", "color":"gray", "italic":false}, {"text":"❤", "color":"yellow", "italic":false}]']}} 4
item replace entity @s hotbar.3 with tipped_arrow{custom_potion_effects:[{id:"levitation", amplifier:3, duration:256}], CustomPotionColor:14219765, HideFlags:63, display:{Name:'{"text":"Flèche de Lévitation", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"--------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⟰ Lévitation IV (0:13)", "color":"#F2F3F4", "italic":false}']}} 5
item replace entity @s hotbar.4 with tipped_arrow{custom_potion_effects:[{id:"slowness", amplifier:3, duration:512}], CustomPotionColor:5592405, HideFlags:63, display:{Name:'{"text":"Flèche de Lenteur", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⬳ Lenteur IV (0:26)", "color":"#555555", "italic":false}']}} 5
give @s splash_potion{Potion:"water", custom_potion_effects:[{id:"speed", amplifier:1, duration:300}], HideFlags:63, display:{Name:'{"text":"Potion de Rapidité", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"➠ Rapidité II (0:15)", "color":"aqua", "italic":false}']}} 3
give @s splash_potion{Potion:"water", custom_potion_effects:[{id:"jump_boost", amplifier:2, duration:600}], HideFlags:63, display:{Name:'{"text":"Potion de Saut", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"-----------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⇪ Sauts améliorés III (0:30)", "color":"green", "italic":false}']}} 4
item replace entity @s armor.head with leather_helmet{Trim:{pattern:vex, material:redstone}, Unbreakable:1, Enchantments:[{id:"protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Chapeau en Cuir", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.chest with golden_chestplate{Trim:{pattern:vex, material:redstone}, Unbreakable:1, Enchantments:[{id:"protection", lvl:2}, {id:"thorns", lvl:3}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Plastron en Or", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"---------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}', '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.legs with leather_leggings{Trim:{pattern:tide, material:redstone}, Unbreakable:1, Enchantments:[{id:"protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Pantalon en Cuir", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.feet with leather_boots{Trim:{pattern:spire, material:redstone}, Unbreakable:1, Enchantments:[{id:"protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Bottes en Cuir", "color":"dark_red", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}']}}
tag @s add cancer_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 10
execute if entity @s[team=sgp.Attaquant] run clear @s
execute if entity @s[team=sgp.Attaquant] run tellraw @s [{"text":"Le kit Cancer n'est pas disponible pour cet event.", "color":"dark_red"}]
scoreboard players set @s sgp.veut_cancer 0
scoreboard players set @s sgp.kit_prefix_set 0