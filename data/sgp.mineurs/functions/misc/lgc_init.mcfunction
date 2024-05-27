#> sgp.mineurs:misc/lgc_init
# 
# Initialize the scoreboard values for the Linear Congruential Generator

# Constantes pour le bon fonctionnement du GCL, à ne pas changer normalement
scoreboard players set #random_calc random_calc 2
scoreboard players set #random_const_mult random_calc 12753
scoreboard players set #random_const_add random_calc 12
scoreboard players set #random_const_mod random_calc 22695471

# Valeurs supérieures et inférieures de l'output (je crois)
scoreboard players set #random_const_out_add random_calc 3
scoreboard players set #random_const_out_mod random_calc 5