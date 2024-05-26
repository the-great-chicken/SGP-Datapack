#> sgp.kits:collection/enderman
# 
# Gives the Enderman kit to the player

clear @s
effect clear @s
tag @s add enderman_voulu
item replace entity @s hotbar.0 with diamond_sword{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:6.0d, Operation:0, UUID:[I; -124310, 12201, 13111, -24402]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Enchantments:[{id:"sweeping_edge", lvl:3}], HideFlags:63, display:{Name:'{"text":"Épée en \'\'Diamant\'\'", "color":"dark_purple", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"❊ Affilage III", "color":"#ADDBD9", "italic":false}', '{"text":"6 dégats", "color":"blue", "italic":false}']}}
item replace entity @s weapon.offhand with chorus_fruit{display:{Name:'{"text":"CorruptedFruit", "color":"dark_purple", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 2", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 64
item replace entity @s hotbar.2 with splash_potion{Potion:"water", custom_potion_effects:[{id:"speed", amplifier:1, duration:440}], HideFlags:63, display:{Name:'{"text":"Potion de Rapidité", "color":"dark_purple", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"➠ Rapidité II (0:22)", "color":"aqua", "italic":false}']}}
item replace entity @s hotbar.1 with ender_pearl{display:{Name:'{"text":"Yeux", "color":"dark_purple", "italic":false, "bold":true}'}} 8
effect give @s regeneration infinite 0
item replace entity @s armor.head with player_head{SkullOwner:"tsukiTAO", Enchantments:[{id:"binding_curse", lvl:1}], HideFlags:5, display:{Name:'{"text":"Tête", "color":"dark_purple", "italic":false, "bold":true}'}}
item replace entity @s armor.chest with leather_chestplate{Trim:{pattern:eye, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:3}, {id:"projectile_protection", lvl:1}], HideFlags:255, display:{color:0, Name:'{"text":"Corps", "color":"dark_purple", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.legs with leather_leggings{Trim:{pattern:dune, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:3}, {id:"projectile_protection", lvl:1}], HideFlags:255, display:{color:0, Name:'{"text":"Jambes", "color":"dark_purple", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.feet with leather_boots{Trim:{pattern:raiser, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:3}, {id:"projectile_protection", lvl:1}], HideFlags:255, display:{color:0, Name:'{"text":"Pieds", "color":"dark_purple", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection III", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection I", "color":"dark_blue", "italic":false}']}}
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 9
scoreboard players set @s sgp.veut_enderman 0
scoreboard players set @s sgp.kit_prefix_set 0