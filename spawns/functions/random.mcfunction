execute store result score #random_spawn_roll test run random value 1..11
execute if score #random_spawn_roll test matches 1 as @s run trigger spawn_1
execute if score #random_spawn_roll test matches 1 as @s run tellraw @s [{"text":"Tu as spawn au "},{"text":"Sumo", "color":"dark_red", "bold":true}]
execute if score #random_spawn_roll test matches 2 as @s run trigger spawn_2
execute if score #random_spawn_roll test matches 2 as @s run tellraw @s [{"text":"Tu as spawn à la "},{"text":"Galerie", "color":"red", "bold":true}]
execute if score #random_spawn_roll test matches 3 as @s run trigger spawn_3
execute if score #random_spawn_roll test matches 3 as @s run tellraw @s [{"text":"Tu as spawn à la "},{"text":"Grande Salle", "color":"dark_purple", "bold":true}]
execute if score #random_spawn_roll test matches 4 as @s run trigger spawn_4
execute if score #random_spawn_roll test matches 4 as @s run tellraw @s [{"text":"Tu as spawn à la "},{"text":"Maison", "color":"#006b3e", "bold":true}]
execute if score #random_spawn_roll test matches 5 as @s run trigger spawn_5
execute if score #random_spawn_roll test matches 5 as @s run tellraw @s [{"text":"Tu as spawn à la "},{"text":"Salle de Repos", "color":"green", "bold":true}]
execute if score #random_spawn_roll test matches 6 as @s run trigger spawn_6
execute if score #random_spawn_roll test matches 6 as @s run tellraw @s [{"text":"Tu as spawn aux "},{"text":"Vallons", "color":"dark_green", "bold":true}]
execute if score #random_spawn_roll test matches 7 as @s run trigger spawn_7
execute if score #random_spawn_roll test matches 7 as @s run tellraw @s [{"text":"Tu as spawn à la "},{"text":"Grange", "color":"gold", "bold":true}]
execute if score #random_spawn_roll test matches 8 as @s run trigger spawn_8
execute if score #random_spawn_roll test matches 8 as @s run tellraw @s [{"text":"Tu as spawn au "},{"text":"Jump", "color":"aqua", "bold":true}]
execute if score #random_spawn_roll test matches 9 as @s run trigger spawn_9
execute if score #random_spawn_roll test matches 9 as @s run tellraw @s [{"text":"Tu as spawn au "},{"text":"Toit", "color":"dark_aqua", "bold":true}]
execute if score #random_spawn_roll test matches 10 as @s run trigger spawn_10
execute if score #random_spawn_roll test matches 10 as @s run tellraw @s [{"text":"Tu as spawn au "},{"text":"Pavillon", "color":"white", "bold":true}]
execute if score #random_spawn_roll test matches 11 as @s run trigger spawn_11
execute if score #random_spawn_roll test matches 11 as @s run tellraw @s [{"text":"Tu as spawn au "},{"text":"Labyrinthe", "color":"light_purple", "bold":true}]
scoreboard players set @s spawn_random 0