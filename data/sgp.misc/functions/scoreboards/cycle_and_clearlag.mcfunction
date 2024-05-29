#> sgp.misc:scoreboards/cycle_and_clearlag
# 
# Cycle the scoreboard displayed on the sidebar, and clears arrows

execute if score #scoreboard_and_clearlag sgp.dummy matches 0 \
    run scoreboard objectives setdisplay sidebar sgp.plus_grande_streak

execute if score #scoreboard_and_clearlag sgp.dummy matches 0 \
    in minecraft:minisjeux_crea \
        run kill @e[type=minecraft:arrow,tag=!global.ignore,tag=!global.ignore.kill]

execute if score #scoreboard_and_clearlag sgp.dummy matches 1 \
    run scoreboard objectives setdisplay sidebar sgp.kills

execute if score #scoreboard_and_clearlag sgp.dummy matches 2 \
    run scoreboard objectives setdisplay sidebar kd



scoreboard players add #scoreboard_and_clearlag sgp.dummy 1

execute if score #scoreboard_and_clearlag sgp.dummy matches 3 \
    run scoreboard players set #scoreboard_and_clearlag sgp.dummy 0

schedule function sgp.misc:scoreboards/cycle_and_clearlag 136