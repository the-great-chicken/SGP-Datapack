#> sgp.mineurs:misc/check_if_players
# 
# Disable the minor events if there isn't any player in the arena

execute as @a[tag=sgp.in_game] run scoreboard players add #nbr_de_joueurs sgp.dummy 1
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Il n'y a pas suffisamment de personnes dans l'arène...", "color":"dark_red"}]
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run function sgp.mineurs:_stop
scoreboard players set #nbr_de_joueurs sgp.dummy 0