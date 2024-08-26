#> sgp.majeurs:pco/cage/check_if_inside
# `{dx1, dz1}`
#
# Check if someone is encaged:
# Return a boolean in the sgp.en_cage scoreboard

$execute if entity @s[dx=$(dx1),dy=3,dz=$(dz1)] \
    run scoreboard players set @s sgp.en_cage 1

$execute as @s[scores={sgp.en_cage=1}] \
    unless entity @s[dx=$(dx1),dy=3,dz=$(dz1)] \
        run scoreboard players set @s sgp.en_cage 0