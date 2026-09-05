# Count every location currently containing the player. These values are reset
# once per tick before all location markers are processed.
scoreboard players add @s sgp.ab.location 1
$scoreboard players add @s sgp.ab.location_width $(width)

$execute if score @s sgp.lieu_$(lieu) matches 0 run function sgp.world:lieu/first_time {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 0 run scoreboard players set @s sgp.lieu_$(lieu) 1

$execute if score @s sgp.lieu_$(lieu) matches 1 run function sgp.world:lieu/second_time {lieu:"$(lieu)", lieu_propre:"$(lieu_propre)", couleur:"$(couleur)"}
$execute if score @s sgp.lieu_$(lieu) matches 1 run function sgp.misc:tab/location/enter {lieu:"$(lieu)"}
