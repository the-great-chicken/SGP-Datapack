#> sgp.kits:collection/items/vindicateur
# 
# Gives the items of the Vindicateur kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with iron_axe{Unbreakable:1, HideFlags:6, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:7, Operation:0, UUID:[I; -124310, 13801, 13111, -27602]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], display:{Name:'{"text":"Hache usée", "color":"dark_green", "italic":false, "bold":true}', Lore:['{"text":"-----------", "color":"#C0C0C0", "italic":false}', '{"text":"7 dégats", "color":"blue", "italic":false}']}}

# ---------- ARMOR PIECES ----------
item replace entity @s armor.head with iron_helmet{Trim:{pattern:rib, material:copper}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Casque en Fer", "color":"dark_green", "italic":false, "bold":true}'}}
item replace entity @s armor.chest with diamond_chestplate{Trim:{pattern:rib, material:copper}, Unbreakable:1, HideFlags:255, display:{Name:'{"text":"Plastron en Diamant", "color":"dark_green", "italic":false, "bold":true}'}}
item replace entity @s armor.legs with leather_leggings{Trim:{pattern:rib, material:copper}, Unbreakable:1, Enchantments:[{id:"thorns", lvl:1}], HideFlags:255, display:{color:9533531, Name:'{"text":"Pantalon en Cuir", "color":"dark_green", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"᠅ Épines I", "color":"dark_green", "italic":false}']}}
item replace entity @s armor.feet with leather_boots{Trim:{pattern:rib, material:copper}, Unbreakable:1, Enchantments:[{id:"thorns", lvl:3}], HideFlags:255, display:{color:9533531, Name:'{"text":"Bottes en Cuir", "color":"dark_green", "italic":false, "bold":true}', Lore:['{"text":"--------------", "color":"#C0C0C0", "italic":false}', '{"text":"᠅ Épines III", "color":"dark_green", "italic":false}']}}

# ---------- POTIONS / ARROWS ----------
item replace entity @s hotbar.2 with splash_potion{Potion:"water", custom_potion_effects:[{id:"weakness", amplifier:0, duration:100}], HideFlags:63, display:{Name:'{"text":"Potion de Faiblesse", "color":"dark_green", "italic":false, "bold":true}', Lore:['{"text":"-------------------", "color":"#C0C0C0", "italic":false}', '{"text":"⬊ Faiblesse I (0:05)", "color":"#777075", "italic":false}']}}

# ---------- FOOD ----------
item replace entity @s hotbar.1 with cooked_beef{display:{Name:'{"text":"Steak", "color":"dark_green", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 32
