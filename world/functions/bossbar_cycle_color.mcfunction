execute if score #bossbar_color test matches 0 run bossbar set minecraft:1 color blue
execute if score #bossbar_color test matches 1 run bossbar set minecraft:1 color purple
execute if score #bossbar_color test matches 2 run bossbar set minecraft:1 color pink 
execute if score #bossbar_color test matches 3 run bossbar set minecraft:1 color white
execute if score #bossbar_color test matches 4 run bossbar set minecraft:1 color red
execute if score #bossbar_color test matches 5 run bossbar set minecraft:1 color yellow

scoreboard players add #bossbar_color test 1
execute if score #bossbar_color test matches 7 run scoreboard players set #bossbar_color test 0
schedule function world:bossbar_cycle_color 8