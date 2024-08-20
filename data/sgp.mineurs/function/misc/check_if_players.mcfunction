#> sgp.mineurs:misc/check_if_players
# 
# Disable the minor events if there isn't any player in the arena

execute store result score #nbr_de_joueurs sgp.dummy run list
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run tellraw @a[tag=sgp.in_game] [{"text":"Il n'y a pas suffisamment de personnes dans l'arène...","color":"dark_red"}]
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run function sgp.mineurs:_stop