execute store result score #random_kit_roll dummy run random value 1..12
execute if score #random_kit_roll dummy matches 1 as @s run trigger veut_combattant
execute if score #random_kit_roll dummy matches 1 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Combattant", "color":"white", "bold":true}]
execute if score #random_kit_roll dummy matches 2 as @s run trigger veut_roi
execute if score #random_kit_roll dummy matches 2 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Roi", "color":"yellow", "bold":true}]
execute if score #random_kit_roll dummy matches 3 as @s run trigger veut_pigeon
execute if score #random_kit_roll dummy matches 3 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Pigeon", "color":"dark_gray", "bold":true}]
execute if score #random_kit_roll dummy matches 4 as @s run trigger veut_archer
execute if score #random_kit_roll dummy matches 4 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Archer", "color":"green", "bold":true}]
execute if score #random_kit_roll dummy matches 5 as @s run trigger veut_tank
execute if score #random_kit_roll dummy matches 5 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Tank", "color":"dark_blue", "bold":true}]
execute if score #random_kit_roll dummy matches 6 as @s run trigger veut_vindicateur
execute if score #random_kit_roll dummy matches 6 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Vindicateur", "color":"dark_green", "bold":true}]
execute if score #random_kit_roll dummy matches 7 as @s run trigger veut_eclaireur
execute if score #random_kit_roll dummy matches 7 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Éclaireur", "color":"aqua", "bold":true}]
execute if score #random_kit_roll dummy matches 8 as @s run trigger veut_poseidon
execute if score #random_kit_roll dummy matches 8 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Poséidon", "color":"dark_aqua", "bold":true}]
execute if score #random_kit_roll dummy matches 9 as @s run trigger veut_alchimiste
execute if score #random_kit_roll dummy matches 9 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Alchimiste", "color":"light_purple", "bold":true}]
execute if score #random_kit_roll dummy matches 10 as @s run trigger veut_enderman
execute if score #random_kit_roll dummy matches 10 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Enderman", "color":"dark_purple", "bold":true}]
execute if score #random_kit_roll dummy matches 11 as @s run trigger veut_cancer
execute if score #random_kit_roll dummy matches 11 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Cancer", "color":"dark_red", "bold":true}]
execute if score #random_kit_roll dummy matches 12 as @s run trigger veut_pyromane
execute if score #random_kit_roll dummy matches 12 as @s run tellraw @s [{"text":"Tu as obtenu le kit "},{"text":"Pyromane", "color":"gold", "bold":true}]
scoreboard players set @s veut_random 0
scoreboard players enable @s veut_random