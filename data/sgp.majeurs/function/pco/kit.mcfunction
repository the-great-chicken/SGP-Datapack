#> sgp.majeurs:pco/kit
# `{color, color_material, color_hex}`
#
# Equips a player with a custom kit for the "Poule-Canard-Oie" game, including
# a feather weapon, bread for healing, and colored leather armor.

clear @s
effect clear @s
item replace entity @s hotbar.0 with feather{AttributeModifiers:[{Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Unbreakable:1, Enchantments:[{id:"unbreaking", lvl:0s}, {id:"sharpness", lvl:1s}], HideFlags:63, display:{Name:'{"text":"Plume","color":"$(color)","italic":false,"bold":true}', Lore:['{"text":"-------------","color":"#C0C0C0","italic":false}', '{"text":"⚔ Tranchant I","color":"dark_red","italic":false}', '{"text":"4 dégats","color":"blue","italic":false}']}}
$item replace entity @s weapon.offhand with bread{display:{Name:'{"text":"Miettes","color":"$(color)","italic":false,"bold":true}', Lore:['[{"text":"Régénère jusqu\'à 3","color":"gray","italic":false},{"text":"❤","color":"red","italic":false}]']}} 64
$item replace entity @s armor.head with leather_helmet{Trim:{pattern:sentry, material:$(color_material)}, Enchantments:[{id:"binding_curse", lvl:1s}], Unbreakable:1, HideFlags:255, display:{color:$(color_hex), Name:'{"text":"Tête","color":"$(color)","italic":false,"bold":true}'}}
$item replace entity @s armor.chest with leather_chestplate{Trim:{pattern:snout, material:quartz}, Enchantments:[{id:"binding_curse", lvl:1s}], Unbreakable:1, HideFlags:255, display:{color:$(color_hex), Name:'{"text":"Corps","color":"$(color)","italic":false,"bold":true}'}}
$item replace entity @s armor.legs with leather_leggings{Trim:{pattern:coast, material:quartz}, Enchantments:[{id:"binding_curse", lvl:1s}], Unbreakable:1, HideFlags:255, display:{color:$(color_hex), Name:'{"text":"Cuisses","color":"$(color)","italic":false,"bold":true}'}}
$item replace entity @s armor.feet with leather_boots{Trim:{pattern:wild, material:gold}, Enchantments:[{id:"binding_curse", lvl:1s}], Unbreakable:1, HideFlags:255, display:{color:$(color_hex), Name:'{"text":"Pattes","color":"$(color)","italic":false,"bold":true}'}}
scoreboard players set @s sgp.reset_tags 1