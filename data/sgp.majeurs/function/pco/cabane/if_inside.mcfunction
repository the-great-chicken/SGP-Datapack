#> sgp.majeurs:pco/cabane/check_if_inside
#
# remove time, give resistance if they have remaining time, else give wither

scoreboard players remove @s sgp.temps_cabane_pco 5

execute if score @s sgp.temps_cabane_pco matches 1.. \
    run effect give @s minecraft:resistance 2 5 false

execute if score @s sgp.temps_cabane_pco matches ..0 \
    run effect give @s minecraft:wither 1 1 false