#> sgp.misc:player_id/allocate
#
# Executed once as a player whose sgp.id score is missing or invalid.

scoreboard players add #global sgp.id 1
scoreboard players operation @s sgp.id = #global sgp.id
