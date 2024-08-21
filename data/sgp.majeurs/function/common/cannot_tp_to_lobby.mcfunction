#> sgp.majeurs:common/cannot_tp_to_lobby
# 
# Executed when a players wants to go to the lobby when a major event is active

tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Vous ne pouvez pas revenir a l'accueil tant que l'événement est actif", "color":"dark_red"}]
scoreboard players enable @s sgp.sort_kits
scoreboard players set @s sgp.sort_kits 0