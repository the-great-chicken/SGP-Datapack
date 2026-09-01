#> sgp.world:lieu/lieu_trouve
# `{dx, dy, dz, lieu, lieu_propre, couleur, width}`
# 
# Show a title to a player who found the place for the first time
# Show an actionbar segment every time they enter the place

data modify storage sgp:macro lieu.current_boxes set value {x:-1,y:-1,z:-1,dx:0,dy:0,dz:0}
data modify storage sgp:macro lieu.current_boxes set from entity @s data.exclusion_box

$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] \
    unless function sgp.world:lieu/check_exclusion_macro \
        run function sgp.world:lieu/main {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)", lieu:"$(lieu)", width:$(width)}

$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] \
    if function sgp.world:lieu/check_exclusion_macro \
        run function sgp.world:lieu/leave {lieu:"$(lieu)"}

$execute as @a[scores={sgp.lieu_$(lieu)=2}] unless entity @s[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/leave {lieu:"$(lieu)"}