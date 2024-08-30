$execute if score @s sgp.lieu_$(lieu) matches 0 run function sgp.world:lieu/first_time {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 0 run scoreboard players set @s sgp.lieu_$(lieu) 1

$execute if score @s sgp.lieu_$(lieu) matches 1 run function sgp.world:lieu/second_time {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 1 run scoreboard players set @s sgp.lieu_$(lieu) 2
