#> sgp.majeurs:pco/cage/check_if_inside
#
# Refresh whether the current player is inside the cage at the execution position.

scoreboard players set @s sgp.en_cage 0
execute if entity @s[distance=..15] \
    at @s if block ~ ~-1 ~ red_concrete \
        run scoreboard players set @s sgp.en_cage 1

execute if entity @s[distance=..15] \
    at @s if block ~ ~-2 ~ red_concrete \
        run scoreboard players set @s sgp.en_cage 1
