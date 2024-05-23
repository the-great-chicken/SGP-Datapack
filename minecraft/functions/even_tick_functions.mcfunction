execute if score #even_tick dummy matches 0 run function sgp.cosmetics:misc/store_coords
execute if score #even_tick dummy matches 0 if score #events_mineurs_actifs dummy matches 1 run function sgp.mineurs:misc/check_if_players
execute if score #even_tick dummy matches 0 if score #events_mineurs_actifs dummy matches 1 run function sgp.mineurs:common/timer

scoreboard players add #even_tick dummy 1

execute if score #even_tick dummy matches 2 run scoreboard players set #even_tick dummy 0