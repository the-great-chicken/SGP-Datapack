#> sgp.world:lieu/main/3
# `{lieu_propre, couleur, lieu, width}`
# Shard 3 (generated): identical to lieu/main; executed as a player inside this shard's marker.
scoreboard players add @s sgp.ab.location 1
$scoreboard players add @s sgp.ab.location_width $(width)
$execute if score @s sgp.lieu_$(lieu) matches 0 run function sgp.world:lieu/first_time {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 0 run scoreboard players set @s sgp.lieu_$(lieu) 1
$execute if score @s sgp.lieu_$(lieu) matches 1 run function sgp.world:lieu/second_time {lieu:"$(lieu)", lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 1 run function sgp.world:lieu/enter {lieu:"$(lieu)"}
