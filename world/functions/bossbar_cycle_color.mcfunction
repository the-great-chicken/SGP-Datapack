execute if score #bossbar_color dummy matches 0 run bossbar set minecraft:1 color blue
execute if score #bossbar_color dummy matches 1 run bossbar set minecraft:1 color purple
execute if score #bossbar_color dummy matches 2 run bossbar set minecraft:1 color pink 
execute if score #bossbar_color dummy matches 3 run bossbar set minecraft:1 color white
execute if score #bossbar_color dummy matches 4 run bossbar set minecraft:1 color red
execute if score #bossbar_color dummy matches 5 run bossbar set minecraft:1 color yellow

scoreboard players add #bossbar_color dummy 1
execute if score #bossbar_color dummy matches 7 run scoreboard players set #bossbar_color dummy 0
schedule function world:bossbar_cycle_color 8