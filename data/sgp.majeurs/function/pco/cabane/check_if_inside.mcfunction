#> sgp.majeurs:pco/cabane/check_if_inside
# `{x, y, z, dx, dz} (coordinates of the cabane)`
# 
# Check if the player is inside the cabane, giving them the appropriate effect
# depending on their time left in sgp.temps_cabane_pco

# If they are inside: remove time ; give resistance if they have remaining time, else give wither
$execute if entity @s[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=2,dz=$(dz)] \
    run scoreboard players remove @s sgp.temps_cabane_pco 5

$execute if entity @s[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=2,dz=$(dz)] \
    if score @s sgp.temps_cabane_pco matches 1.. run effect give @s minecraft:resistance 2 5 false

$execute if entity @s[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=2,dz=$(dz)] \
    if score @s sgp.temps_cabane_pco matches ..0 run effect give @s minecraft:wither 1 1 false

# If they are not inside: add time
$execute unless entity @s[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=2,dz=$(dz)] run scoreboard players add @s sgp.temps_cabane_pco 1