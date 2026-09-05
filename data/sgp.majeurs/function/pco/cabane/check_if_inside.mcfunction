#> sgp.majeurs:pco/cabane/check_if_inside
#
# Spend refuge time when the player is inside; otherwise recharge it.

execute if entity @s[distance=..15] at @s \
    if block ~ ~-1 ~ green_concrete \
        run return run function sgp.majeurs:pco/cabane/if_inside
scoreboard players add @s sgp.temps_cabane_pco 1
