#> sgp.world:lieu_trouve
# `{dx, dy, dz, lieu, lieu_propre, couleur}`
# 
# Show a title to a player who found the place for the first time
# Show a actionbar every time they enter the place

$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/main {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)", lieu:"$(lieu)"}
$execute as @a[scores={sgp.lieu_$(lieu)=2}] unless entity @s[dx=$(dx), dy=$(dy), dz=$(dz)] run scoreboard players set @s sgp.lieu_$(lieu) 1