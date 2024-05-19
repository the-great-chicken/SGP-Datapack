execute store result score #nbr_de_joueurs test run list
execute if score #nbr_de_joueurs test <= 1 test run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] [{"text":"Personne n'est dans l'arène...","color":"dark_red"}]
execute if score #nbr_de_joueurs test <= 1 test run function mineurs:stop