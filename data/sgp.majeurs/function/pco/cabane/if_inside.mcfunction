#> sgp.majeurs:pco/cabane/if_inside
#
# Spend refuge time. Exhaustion stops at zero and immediately replaces protection with the Wither penalty.

scoreboard players remove @s sgp.temps_cabane_pco 5

execute if score @s sgp.temps_cabane_pco matches 1.. \
    run return run effect give @s minecraft:resistance 2 5 false

scoreboard players set @s sgp.temps_cabane_pco 0
effect clear @s minecraft:resistance
effect give @s minecraft:wither 1 1 false
