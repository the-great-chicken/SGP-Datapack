#> sgp.kits:collection/pigeon
# 
# Gives the Pigeon kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with feather{AttributeModifiers:[{Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Unbreakable:1, Enchantments:[{id:"knockback", lvl:3}, {id:"sharpness", lvl:5}], HideFlags:63, display:{Name:'{"text":"Plume", "color":"dark_gray", "italic":false, "bold":true}', Lore:['{"text":"-------------", "color":"#C0C0C0", "italic":false}', '{"text":"⚔ Tranchant V", "color":"dark_red", "italic":false}', '{"text":"⬱ Recul III", "color":"#6F4E37", "italic":false}', '{"text":"4 dégats", "color":"blue", "italic":false}']}}
item replace entity @s hotbar.1 with bow{Enchantments:[{id:"power", lvl:2}, {id:"infinity", lvl:1}], HideFlags:5, Unbreakable:1, display:{Name:'{"text":"Lance Plumes", "color":"dark_gray", "italic":false, "bold":true}', Lore:['{"text":"-------------", "color":"#C0C0C0", "italic":false}', '{"text":"🏹 Puissance II", "color":"dark_red", "italic":false}', '{"text":"∞ Infinité", "color":"#E5E4E2", "italic":false}']}}
item replace entity @s weapon.offhand with bread{display:{Name:'{"text":"Miettes", "color":"dark_gray", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 64
item replace entity @s inventory.8 with arrow{display:{Name:'{"text":"uwu", "italic":false}'}}
item replace entity @s hotbar.2 with firework_rocket{Fireworks:{}, display:{Name:'{"text":"Boost", "color":"dark_gray", "italic":false, "bold":true}'}} 5
effect give @s jump_boost infinite 2
item replace entity @s armor.head with player_head{SkullOwner:"__pif__", Enchantments:[{id:"binding_curse", lvl:1}], HideFlags:5, display:{Name:'{"text":"Tête", "color":"dark_gray", "italic":false, "bold":true}'}}
item replace entity @s armor.chest with elytra{Unbreakable:1, HideFlags:4, display:{Name:'{"text":"Ailes", "color":"dark_gray", "italic":false, "bold":true}'}}
item replace entity @s armor.legs with chainmail_leggings{Unbreakable:1, HideFlags:6, display:{Name:'{"text":"Cuisses", "color":"dark_gray", "italic":false, "bold":true}'}}
item replace entity @s armor.feet with chainmail_boots{Unbreakable:1, Enchantments:[{id:"protection", lvl:2}], HideFlags:7, display:{Name:'{"text":"Pattes", "color":"dark_gray", "italic":false, "bold":true}', Lore:['{"text":"-------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection II", "color":"dark_aqua", "italic":false}']}}
tag @s add pigeon_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 0
execute if entity @s[team=sgp.Attaquant] run clear @s
execute if entity @s[team=sgp.Attaquant] run tellraw @s [{"text":"Le kit Pigeon n'est pas disponible pour cet event.","color":"dark_red"}]
scoreboard players set @s sgp.veut_pigeon 0
scoreboard players set @s sgp.kit_prefix_set 0