#> sgp.world:lieu_trouve
# `{dx, dy, dz, lieu, lieu_propre, couleur, width}`
# 
# Show a title to a player who found the place for the first time
# Show an actionbar segment every time they enter the place

$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/main {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)", lieu:"$(lieu)", width:$(width)}
$execute as @a[scores={sgp.lieu_$(lieu)=2}] unless entity @s[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/leave {lieu:"$(lieu)"}