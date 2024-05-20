execute if score #scoreboard_and_clearlag test matches 0 run scoreboard objectives setdisplay sidebar plus_grande_streak
execute if score #scoreboard_and_clearlag test matches 0 run execute in minecraft:minisjeux_crea run kill @e[type=minecraft:arrow]
execute if score #scoreboard_and_clearlag test matches 1 run scoreboard objectives setdisplay sidebar kills
execute if score #scoreboard_and_clearlag test matches 2 run scoreboard objectives setdisplay sidebar kd

scoreboard players add #scoreboard_and_clearlag test 1
execute if score #scoreboard_and_clearlag test matches 3 run scoreboard players set #scoreboard_and_clearlag test 0
schedule function world:cycle_scoreboards_and_clearlag 136