#> sgp.majeurs:protect/king_effect
# `{color, team}`
#
# Give an effect to the players that are near the king,
# showing the radius of the effect with particles

$execute at @s run particle dust{color:$(color), scale:1} ~ ~ ~ 3 3 3 1 10

$execute at @s as @a[distance=..5,team=sgp.$(team)] \
    run effect give @s minecraft:health_boost 3 0 true