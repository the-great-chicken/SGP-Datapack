#> sgp.majeurs:pco/cage/check_if_inside
#
# Check if someone is encaged:
# Return a boolean in the sgp.en_cage scoreboard

execute if entity @s[distance=..15] \
    at @s if block ~ ~-1 ~ red_concrete \
        run scoreboard players set @s sgp.en_cage 1

execute if entity @s[distance=..15] \
    at @s if block ~ ~-2 ~ red_concrete \
        run scoreboard players set @s sgp.en_cage 1
    
execute as @s[scores={sgp.en_cage=1}] at @s \
    unless block ~ ~-1 ~ red_concrete \
    unless block ~ ~-2 ~ red_concrete \
        run scoreboard players set @s sgp.en_cage 0