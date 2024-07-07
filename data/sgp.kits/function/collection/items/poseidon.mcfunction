#> sgp.kits:collection/items/poseidon
# 
# Gives the items of the Poseidon kit to the player

# ---------- WEAPONS ----------
give @s trident{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:7.5d, Operation:0, UUID:[I; -124310, 13601, 13111, -27202]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Enchantments:[{id:"impaling", lvl:4}], HideFlags:63, display:{Name:'{"text":"Trident", "color":"dark_aqua", "italic":false, "bold":true}', Lore:['{"text":"---------", "color":"#C0C0C0", "italic":false}', '{"text":"7,5 dégats", "color":"blue", "italic":false}']}} 17

# ---------- FOOD ----------
item replace entity @s weapon.offhand with cooked_cod{display:{Name:'{"text":"Morue", "color":"dark_aqua", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 2,5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 64
