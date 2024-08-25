execute as @a[tag=sgp.in_game] run experience add @s -1 levels
scoreboard players remove #second sgp.timer 1
execute if score #second sgp.timer matches 1.. run return run schedule function sgp.misc:second 1s

execute as @a[tag=sgp.in_game] run experience set @s 0 levels
execute as @a[tag=sgp.in_game] run experience set @s 0 points