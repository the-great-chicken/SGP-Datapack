execute if score #even_tick test matches 0 run function cosm:store_coords
execute if score #even_tick test matches 0 as @r run function world:init_scoreboards

scoreboard players add #even_tick test 1

execute if score #even_tick test matches 2 run scoreboard players set #even_tick test 0