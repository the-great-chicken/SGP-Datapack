#> sgp.mineurs:misc/check_if_players
# 
# Disable the minor events if there isn't any player in the arena

execute store result score #nbr_de_joueurs sgp.dummy run list
execute if score #nbr_de_joueurs sgp.dummy <= 1 sgp.dummy run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] [{"text":"Personne n'est dans l'arène...","color":"dark_red"}]
execute if score #nbr_de_joueurs sgp.dummy <= 1 sgp.dummy run function sgp.mineurs:common/stop