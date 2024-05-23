execute if score #bossbar_color sgp.dummy matches 0 run bossbar set minecraft:1 color blue
execute if score #bossbar_color sgp.dummy matches 1 run bossbar set minecraft:1 color purple
execute if score #bossbar_color sgp.dummy matches 2 run bossbar set minecraft:1 color pink 
execute if score #bossbar_color sgp.dummy matches 3 run bossbar set minecraft:1 color white
execute if score #bossbar_color sgp.dummy matches 4 run bossbar set minecraft:1 color red
execute if score #bossbar_color sgp.dummy matches 5 run bossbar set minecraft:1 color yellow

scoreboard players add #bossbar_color sgp.dummy 1
execute if score #bossbar_color sgp.dummy matches 7 run scoreboard players set #bossbar_color sgp.dummy 0
schedule function sgp.misc:bossbar/cycle_color 8