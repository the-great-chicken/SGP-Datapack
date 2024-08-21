#> sgp.kits:misc/random
# 
# Rolls a random number between 1 and 12, and runs the corresponding kit function
# to give it to the player

execute store result score #random_kit_roll sgp.dummy run random value 1..12
execute if score #random_kit_roll sgp.dummy matches 1 as @s run trigger sgp.veut_combattant
execute if score #random_kit_roll sgp.dummy matches 1 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Combattant", "color":"white", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 2 as @s run trigger sgp.veut_roi
execute if score #random_kit_roll sgp.dummy matches 2 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Roi", "color":"yellow", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 3 as @s run trigger sgp.veut_pigeon
execute if score #random_kit_roll sgp.dummy matches 3 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Pigeon", "color":"dark_gray", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 4 as @s run trigger sgp.veut_archer
execute if score #random_kit_roll sgp.dummy matches 4 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Archer", "color":"green", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 5 as @s run trigger sgp.veut_tank
execute if score #random_kit_roll sgp.dummy matches 5 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Tank", "color":"dark_blue", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 6 as @s run trigger sgp.veut_vindicateur
execute if score #random_kit_roll sgp.dummy matches 6 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Vindicateur", "color":"dark_green", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 7 as @s run trigger sgp.veut_eclaireur
execute if score #random_kit_roll sgp.dummy matches 7 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Éclaireur", "color":"aqua", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 8 as @s run trigger sgp.veut_poseidon
execute if score #random_kit_roll sgp.dummy matches 8 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Poséidon", "color":"dark_aqua", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 9 as @s run trigger sgp.veut_alchimiste
execute if score #random_kit_roll sgp.dummy matches 9 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Alchimiste", "color":"light_purple", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 10 as @s run trigger sgp.veut_enderman
execute if score #random_kit_roll sgp.dummy matches 10 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Enderman", "color":"dark_purple", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 11 as @s run trigger sgp.veut_cancer
execute if score #random_kit_roll sgp.dummy matches 11 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Cancer", "color":"dark_red", "bold":true}]
execute if score #random_kit_roll sgp.dummy matches 12 as @s run trigger sgp.veut_pyromane
execute if score #random_kit_roll sgp.dummy matches 12 as @s run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"Pyromane", "color":"gold", "bold":true}]
scoreboard players set @s sgp.veut_random 0
scoreboard players enable @s sgp.veut_random