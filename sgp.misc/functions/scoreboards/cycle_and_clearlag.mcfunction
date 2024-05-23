execute if score #scoreboard_and_clearlag dummy matches 0 run scoreboard objectives setdisplay sidebar plus_grande_streak
execute if score #scoreboard_and_clearlag dummy matches 0 run execute in minecraft:minisjeux_crea run kill @e[type=minecraft:arrow]
execute if score #scoreboard_and_clearlag dummy matches 1 run scoreboard objectives setdisplay sidebar kills
execute if score #scoreboard_and_clearlag dummy matches 2 run scoreboard objectives setdisplay sidebar kd

scoreboard players add #scoreboard_and_clearlag dummy 1
execute if score #scoreboard_and_clearlag dummy matches 3 run scoreboard players set #scoreboard_and_clearlag dummy 0
schedule function sgp.misc:scoreboards/cycle_and_clearlag 136