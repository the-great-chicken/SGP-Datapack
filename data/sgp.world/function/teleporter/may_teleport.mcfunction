#> sgp.world:teleporter/may_teleport
# 
# When the player gets on the teleporter

playsound minecraft:block.portal.trigger ambient @s ~ ~ ~ 2 1.3
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Ⓞ ","color":"#700070"},{"text":"Téléportation dans 3 secondes... Ne bougez pas...","color":"dark_purple","bold":true}]
tag @s add sgp.to_teleport