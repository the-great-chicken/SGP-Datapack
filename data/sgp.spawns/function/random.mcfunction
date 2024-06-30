#> sgp.spawns:random
# 
# Generate a random number and tp the player to the corresponding spawn

scoreboard players set #number_of_spawns sgp.dummy 0
execute as @e[type=marker,tag=sgp.marker,name="spawn"] store result score @s sgp.dummy run data get entity @s data.number
execute as @e[type=marker,tag=sgp.marker,name="spawn"] run scoreboard players operation #number_of_spawns sgp.dummy > @s sgp.dummy

execute store result storage sgp:dummy spawn_random.max int 1 run scoreboard players get #number_of_spawns sgp.dummy
execute store result score #random_spawn_roll sgp.dummy run function sgp.misc:random_value with storage sgp:dummy spawn_random

tag @s add sgp.random_spawn
execute as @e[type=marker,tag=sgp.marker,name="spawn"] if score #random_spawn_roll sgp.dummy = @s sgp.dummy run function sgp.spawns:trigger_spawn with entity @s data
tag @s remove sgp.random_spawn

scoreboard players set @s sgp.spawn_random 0