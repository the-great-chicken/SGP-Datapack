setblock 2469 18 2025 minecraft:redstone_block
execute if score #degats_barriere dummy matches 0 run setblock 2480 18 2038 minecraft:redstone_block
execute if score #degats_barriere dummy matches 1 run setblock 2480 18 2036 minecraft:redstone_block
execute if score #degats_barriere dummy matches 2 run setblock 2480 18 2034 minecraft:redstone_block
execute if score #degats_barriere dummy matches 3 run setblock 2480 18 2032 minecraft:redstone_block
execute if score #degats_barriere dummy matches 4 run fill 2408 143 2053 2546 282 2109 minecraft:lime_stained_glass replace minecraft:green_stained_glass

execute if score #degats_barriere dummy matches 5 run setblock 2477 18 2038 minecraft:redstone_block
execute if score #degats_barriere dummy matches 6 run setblock 2477 18 2036 minecraft:redstone_block
execute if score #degats_barriere dummy matches 7 run setblock 2477 18 2034 minecraft:redstone_block
execute if score #degats_barriere dummy matches 8 run setblock 2477 18 2032 minecraft:redstone_block
execute if score #degats_barriere dummy matches 9 run fill 2408 143 2053 2546 282 2109 minecraft:yellow_stained_glass replace minecraft:lime_stained_glass

execute if score #degats_barriere dummy matches 10 run setblock 2474 18 2038 minecraft:redstone_block
execute if score #degats_barriere dummy matches 11 run setblock 2474 18 2036 minecraft:redstone_block
execute if score #degats_barriere dummy matches 12 run setblock 2474 18 2034 minecraft:redstone_block
execute if score #degats_barriere dummy matches 13 run setblock 2474 18 2032 minecraft:redstone_block
execute if score #degats_barriere dummy matches 14 run fill 2408 143 2053 2546 282 2109 minecraft:orange_stained_glass replace minecraft:yellow_stained_glass

execute if score #degats_barriere dummy matches 15 run setblock 2471 18 2038 minecraft:redstone_block
execute if score #degats_barriere dummy matches 16 run setblock 2471 18 2036 minecraft:redstone_block
execute if score #degats_barriere dummy matches 17 run setblock 2471 18 2034 minecraft:redstone_block
execute if score #degats_barriere dummy matches 18 run setblock 2471 18 2032 minecraft:redstone_block
execute if score #degats_barriere dummy matches 19 run fill 2408 143 2053 2546 282 2109 minecraft:red_stained_glass replace minecraft:orange_stained_glass

execute if score #degats_barriere dummy matches 20 run setblock 2468 18 2038 minecraft:redstone_block
execute if score #degats_barriere dummy matches 21 run setblock 2468 18 2036 minecraft:redstone_block
execute if score #degats_barriere dummy matches 22 run setblock 2468 18 2034 minecraft:redstone_block
execute if score #degats_barriere dummy matches 23 run setblock 2468 18 2032 minecraft:redstone_block
execute if score #degats_barriere dummy matches 24 run setblock 2480 18 2026 minecraft:redstone_block

scoreboard players add #degats_barriere dummy 1
scoreboard players set #tir_charged dummy 0