clear @s
effect clear @s
give @s trident{Unbreakable:1, AttributeModifiers:[{AttributeName:"generic.attack_damage", Name:"Damage", Slot:"mainhand", Amount:7.5d, Operation:0, UUID:[I; -124310, 13601, 13111, -27202]}, {Slot:"mainhand", AttributeName:"generic.attack_speed", Name:"generic.attack_speed", Amount:1000.0d, Operation:0, UUID:[I; -110663, 103297, -1423577, 206238]}], Enchantments:[{id:"impaling", lvl:4}], HideFlags:63, display:{Name:'{"text":"Trident", "color":"dark_aqua", "italic":false, "bold":true}', Lore:['{"text":"---------", "color":"#C0C0C0", "italic":false}', '{"text":"7,5 dégats", "color":"blue", "italic":false}']}} 17
item replace entity @s weapon.offhand with cooked_cod{display:{Name:'{"text":"Morue", "color":"dark_aqua", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 2,5", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 64
effect give @s slowness infinite 3
effect give @s resistance infinite 2
effect give @s hunger infinite 3
item replace entity @s hotbar.1 with air
tag @s add poseidon_a_setup_egapp
tag @s add poseidon_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 11
scoreboard players set @s sgp.veut_poseidon 0
scoreboard players set @s sgp.kit_prefix_set 0