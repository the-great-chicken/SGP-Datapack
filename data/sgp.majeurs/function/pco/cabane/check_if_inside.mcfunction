#> sgp.majeurs:pco/cabane/check_if_inside
# 
# Check if the player is inside the cabane, giving them the appropriate effect
# depending on their time left in sgp.temps_cabane_pco

# If they are inside
execute if entity @s[distance=..20] \
    at @s if block ~ ~-1 ~ green_concrete \
        run function sgp.majeurs:pco/cabane/if_inside

# If they are not inside: add time
execute at @s unless block ~ ~-1 ~ green_concrete \
    run scoreboard players add @s sgp.temps_cabane_pco 1